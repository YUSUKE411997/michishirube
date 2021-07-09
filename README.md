
# MICHI SHIRU　（ミチシル）　　
若者の将来の道を切り開く、ミチシルベとなるようなサイト

## サイト概要
将来やりたい事がわからない人や、あるけど不安で行動に移せない人、行動に移せた人達が  
現状の気持ちや目標を投稿するサイト　　
レスポンシブ非対応の為、PC推奨


### 制作理由
身近の友人や知人からよく「やりたい事がわからない」「やりたい事があるけど行動できない」と耳にします。  とある調査では約40％の若者がやりたい事が見つからないという結果になっております。  
実際に私自身も卒業してから、本当にやりたい事ってなんだろうと考えておりました。  そこで私自身の経験も踏まえて話すと
やりたい事を見つける方法は「実際に経験する事」だと私は思います。  その経験するというハードルを下げるにはモデルケースを周りに増やす事だと思います。
またやりたい事はあっても行動に移せない人も同様に、モデルケースが少ない事が要因だと思っています。  
その情報収集に繋がるようなサービスを作り多くの若者の手助けになりたいと考え、今回のアプリケーションを作りました。



### ターゲットユーザ
やりたい事がわからない人  
やりたい事はあるけどなかなか行動に移せない人  
モデルケースを知りたい人  
  
### 主な利用シーン
興味がある仕事の実体験を他の人から聞きたい時  
同じ志の人同士でコミュニティが欲しい時  
やりたい事が見つからない人で、どんな仕事があるのか知りたい時  
気持ちに共感を得て欲しい時  

## 設計書
画面設計  
https://docs.google.com/spreadsheets/d/1qb8cQ797p0gBcYPZbN4am8_QPEv4iGqZg2l5kxim7Kk/edit#gid=0  
画面遷移図  
https://app.diagrams.net/#G16LJ8hLYMzaWq36eX9KiscTcziwP0PGkE  
ER図  
https://app.diagrams.net/#G1rOGHc2UKksl_D3d_kBm3OAD1G2Wjui7l  
テーブル定義書  
https://docs.google.com/spreadsheets/d/1PTFXG8k77SbmS_9Tf4PwPwYl3NyCmDTP-uYDQjlgl_A/edit#gid=1658977349  
詳細設計  
https://docs.google.com/spreadsheets/d/1moCRso_14LOik8zKSRHhCpA4BTvvg0H9Cz1Mh5PUmG4/edit#gid=1691749220  

## チャレンジ要素一覧
https://docs.google.com/spreadsheets/d/1VG5Y7x8891qPpJAbR8QjmZ2yJOvPXqECHvnybG1uhcw/edit#gid=0

## 使用技術
- Ruby 2.6.3  
- Ruby on Rails 5.2.5  
- MySQL 5.7.22  
- Nginx  
- Puma  
- AWS  
  - VPC  
  - EC2  
  - RDS  
- RSpec  

## 機能一覧  
- ユーザー認証・管理者認証（devise）
  - ゲストログイン
  - ユーザー認証（Ajax）
- 管理機能
  - 会員編集（退会・編集）
  - 投稿削除
- 投稿機能
  - コメント機能（Ajax）
  - いいね機能（Ajax）
  - リツイート機能（Ajax）
  - タグ機能
- フォロー機能（Ajax）
- 検索機能
- 通知機能（いいね・コメント・リツイート・フォロー・メッセージ）
- メッセージ機能（Ajax）
- カレンダー機能（simple_calendar）
  - 自動追加（やってみた投稿の場合）
  - 予定追加（やってみたい投稿の場合）
- プレビュー機能
  - 閲覧履歴（投稿を最後に閲覧した時間表示）
- タイムライン機能（自分とフォローしたユーザー）
  - 投稿表示
  - リツイート・いいねされた投稿
- ランキング機能
  - １週間ごとにランキング（タグ・リツイート・プレビュー・投稿のいいね数（３種類の投稿））
- ページング機能
  - 無限スクロール（Ajax）
- N+1問題（bullet）

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材
- 外部サービスの画像素材・音声素材を使用した場合は、必ずサービス名とURLを明記してください。
- 使用しない場合は、使用素材の項目をREADMEから削除してください。
