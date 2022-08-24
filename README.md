# hatsunetsu-kun
# サービス概要
 LINEbotで、発熱した時に受診できる現在地から近い病院を簡単に検索することができる
# メインのターゲットユーザー

発熱のあった人

コロナに感染した恐れがある人

# ユーザーが抱える問題
東京都ではコロナ感染者数が爆発的に増え、病院の予約を取るのが困難になっている。
また、東京消防庁の救急車出動率が98%を超える日もあり、救急現場がひっ迫している
感染者数が多すぎて、急に熱が出た時に、保健所や相談室に連絡してもなかなか繋がらない。
# 解決方法
LINEbot上で、かかりつけ医以外、発熱がある場合でも受診できて、PCR検査ができる病院を表示させる
救急車を呼ぶか判断に迷った時の基準や、移動手段を案内させる

# 既存のアプリとの差別化

既存のアプリ

• [https://www.fukushihoken.metro.tokyo.lg.jp/iryo/kansen/coronasodan.html](https://www.fukushihoken.metro.tokyo.lg.jp/iryo/kansen/coronasodan.html)

既存のアプリだと、リンクからマップに遷移して、自分で絞り込み検索をしないといけないのが手間なので
LINEbot上に結果を表示させて、ユーザーの負担を減らす

救急車が必要か判断基準も表示させて
発熱者専用タクシーの案内で交通手段を提案さsる→不要な救急車要請を減らす


# 実装予定の機能

・LINEbotの各メニューで案内をそれぞれ表示させる
・現在地から条件に合う病院を近い順に表示できる機能

# 使用技術

・Rails 6.1.6.
・LINE Messaging API

# スケジュール

8/17~ ER図・画面遷移図

8/22~ ER図・画面遷移図 完成

8/22~24 LINE botのキャッチアップと役割分担(先輩のリポジトリ見ながら)

8/26~ 機能実装開始

~9/18 締切！！

## ER図

[ER図のリンク](https://app.diagrams.net/#G1RX9K_lTSCCn81BD92oMgs89M2aK57LDR)

## 画面遷移図

[画面遷移図のリンク](https://www.figma.com/file/9nPR7ecWOiG9G3uLVy2gAK/asakai?node-id=0%3A1)
