class LineBotController < ApplicationController
  protect_from_forgery except: [:callback]
  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    return head :bad_request unless client.validate_signature(body, signature)

    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if /移動手段（かかりつけ医がいる方）/.match?(event.message['text'])
            message = {
              "type": 'text',
              "text": "移動手段を以下の手順で検討してみてください
                      \n1.自家用車がある場合
                      \n自家用車でのご移動をお願いします
                      \n2.自家用車がない場合
                      \n発熱タクシー（有料）をご検討ください
                      \n発熱タクシーのURL
                      \n3.公共交通機関を利用の場合
                      \nもし公共交通機関を利用する場合は感染対策を徹底して人と距離をとり移動すること
                      \n4.上記の移動手段が困難な場合
                      \n救急車をご検討ください。救急車を呼ぶか迷った場合はこちらを参照ください。
                      \n参考記事のurl"
            }
            client.reply_message(event['replyToken'], message)
          end
          if /コロナまたはCOCOA通知について相談したい方/.match?(event.message['text'])
            message = {
              "type": 'text',
              "text": "COCOA通知がきて相談したい方は【東京都発熱相談センターCOCOA専用ダイヤル】で相談できます。\n[電話番号]000-0000-0000
                      \n新型コロナに対して不安に思う方は【新型コロナ・オミクロン株コールセンター】で相談ができます。\n[電話番号]0570-550571"
            }
            client.reply_message(event['replyToken'], message)
          end
          if /診療可能な病院を探す/.match?(event.message['text'])
            if LineUser.find_by(line_user_id: params[:events][0][:source][:userId]).nil?
              LineUser.create!(line_user_id: params[:events][0][:source][:userId])
            end
            message = {
              "type": 'text',
              "text": "【該当の番号を、入力してメッセージで送信してください】
                      \n1.近くの診療可能な医療機関を検索\n2.東京都発熱相談センターへ相談する"
            }
            client.reply_message(event['replyToken'], message)
          end
          if /1/.match?(event.message['text'])
            message = {
              "type": 'text',
              "text": "近くの病院を検索中
                      \n以下のいずれかのケースに該当しますか？【該当の番号を、入力してメッセージで送信してください】\n 3.妊娠している\n 4.発熱者が児童である\n 5.該当しない"
            }
            client.reply_message(event['replyToken'], message)
          end
          if /5/.match?(event.message['text'])
            user = LineUser.find_by(line_user_id: params[:events][0][:source][:userId])
            user.update!(select_type: 5)
            client.reply_message(event['replyToken'], template)
          end
          if /4/.match?(event.message['text'])
            user = LineUser.find_by(line_user_id: params[:events][0][:source][:userId])
            user.update!(select_type: 4)
            client.reply_message(event['replyToken'], template)
          end
          if /3/.match?(event.message['text'])
            user = LineUser.find_by(line_user_id: params[:events][0][:source][:userId])
            user.select_type = 3
            user.update!
            client.reply_message(event['replyToken'], template)
          end
        when Line::Bot::Event::MessageType::Location
          current_user = LineUser.find_by(line_user_id: params[:events][0][:source][:userId])
          latitude = event['message']['latitude']
          longitude = event['message']['longitude']
          user_address = Geocoder.search([latitude, longitude])
          user_location = Hospital.create!(name: 'ユーザー現在地', address: user_address.first.address, phone_number: '090',
                                           url: 'url', latitude:, longitude:)
          near_hospitals = user_location.nearbys(5, units: :km).limit(5)
          message = { type: 'text', text: '近くに病院がありません。条件を変えて再検索してください' } if near_hospitals.empty?
          case current_user.select_type
          when 5
            message = {
              type: 'flex',
              altText: '病院検索の結果です',
              contents: set_carousel(near_hospitals)
            }
          when 4
            near_hospitals_childs = near_hospitals.select { |hospital| hospital.target_group.child == 'available' }
            message = {
              type: 'flex',
              altText: '病院検索の結果です',
              contents: set_carousel(near_hospitals_childs)
            }
          else
            near_hospitals_pregnants = near_hospitals.select do |hospital|
              hospital.target_group.pregnant == 'available'
            end
            message = {
              type: 'flex',
              altText: '病院検索の結果です',
              contents: set_carousel(near_hospitals_pregnants)
            }
          end
          client.reply_message(event['replyToken'], message)
          user_location.destroy!
        end
      end
    end
    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = Rails.application.credentials.dig(:line, :channel_secret)
      config.channel_token = Rails.application.credentials.dig(:line, :channel_token)
    end
  end

  def template
    {
      "type": 'template',
      "altText": '位置検索中',
      "template": {
        "type": 'buttons',
        "title": '近くの病院を探す',
        "text": '現在の位置を送信しますか？',
        "actions": [
          {
            "type": 'uri',
            "label": '位置を送る',
            "uri": 'line://nv/location'
          }
        ]
      }
    }
  end

  def set_bubble(hospital)
    {
      type: 'bubble',
      body: set_body(hospital)

    }
  end

  def set_carousel(near_hospitals)
    bubbles = []
    near_hospitals.each do |hospital|
      bubbles.push set_bubble(hospital)
    end
    {
      type: 'carousel',
      contents: bubbles
    }
  end

  def set_body(hospital)
    {
      type: 'box',
      layout: 'vertical',
      contents: [
        {
          type: 'text',
          text: hospital.name,
          wrap: true,
          weight: 'bold',
          size: 'md'
        },
        {
          type: 'box',
          layout: 'vertical',
          margin: 'lg',
          spacing: 'sm',
          contents: [
            {
              type: 'box',
              layout: 'baseline',
              spacing: 'sm',
              contents: [
                {
                  type: 'text',
                  text: '住所',
                  color: '#aaaaaa',
                  size: 'sm',
                  flex: 1
                },
                {
                  type: 'text',
                  text: hospital.address,
                  wrap: true,
                  color: '#666666',
                  size: 'sm',
                  flex: 5
                }
              ]
            },
            {
              type: 'box',
              layout: 'baseline',
              spacing: 'sm',
              contents: [
                {
                  type: 'text',
                  text: '電話番号',
                  color: '#aaaaaa',
                  size: 'sm',
                  flex: 1
                },
                {
                  type: 'text',
                  text: hospital.phone_number,
                  wrap: true,
                  color: '#666666',
                  size: 'sm',
                  flex: 5
                }
              ]
            }
          ]
        }
      ]
    }
  end
end
