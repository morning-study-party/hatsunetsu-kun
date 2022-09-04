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
          message = {
            type: 'text',
            text: event.message['text']
          }
          if /移動手段（かかりつけ医がいる方）/.match?(event.message['text'])
            message = {
              "type": 'text',
              "text": "移動手段を以下の手順で検討してみてください
1.自家用車がある場合
自家用車でのご移動をお願いします
2.自家用車がない場合
発熱タクシー（有料）をご検討ください
発熱タクシーのURL
3.公共交通機関を利用の場合
もし公共交通機関を利用する場合は感染対策を徹底して人と距離をとり移動すること
4.上記の移動手段が困難な場合
救急車をご検討ください。救急車を呼ぶか迷った場合はこちらを参照ください。
参考記事のurl"
            }
            client.reply_message(event['replyToken'], message)
          end
          if /コロナまたはCOCOA通知について相談したい方/.match?(event.message['text'])
            message = {
              "type": 'text',
              "text": "COCOA通知がきて相談したい方は【東京都発熱相談センターCOCOA専用ダイヤル】で相談できます。
[電話番号]000-0000-0000"
            }
            client.reply_message(event['replyToken'], message)
          end
          if /診療可能な病院を探す/.match?(event.message['text'])
            message = {
              "type": 'text',
              "text": "【該当の番号を、入力してメッセージで送信してください】
1.近くの診療可能な医療機関を検索
2.東京都発熱相談センターへ相談する"
            }
            client.reply_message(event['replyToken'], message)
          end
          if /1/.match?(event.message['text'])
            message = {
              "type": 'text',
              "text": "近くの病院を検索中
以下のいずれかのケースに該当しますか？【該当の番号を、入力してメッセージで送信してください】
3.妊娠している
4.発熱者が児童である
5.該当しない"
            }
            client.reply_message(event['replyToken'], message)
          end
          if /5/.match?(event.message['text'])
            message = {
              "type": 'text',
              "text": '診療可能な病院が○件見つかりました'
            }
            client.reply_message(event['replyToken'], message)
          end
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
end
