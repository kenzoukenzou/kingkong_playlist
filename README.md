## 概要
「毎週キングコング」というYoutubeチャンネルの動画だけを集めたサービスです。
ログインをすると、以下のことができます。

- タイムスタンプとコメントを残せる
- タイムスタンプで動画を指定位置から再生できる
- プレイリストを作成できる

[同じ機能を持つVueだけで作ったサービス](https://devtube-7014c.web.app/#/)で動作イメージをご確認いただけます。

## 使用技術

- バックエンド：
  - Ruby on Rails APIモード
  - SQLite(開発環境)
  - Postgresql(本番)
  - Heroku
- フロントエンド：
  - Vue.js
  - Vuetify
  - Firebase

なお、認証はFierbase Authenticationを使用しています。

## 環境構築

```shell
# Backend
$ cd backend/
$ rails db:create db:migrate
$ bundle install
```

```shell
# Frontend
$ cd frontend/
$ yarn
```

```shell
$ cd backend/
$ rails s

$ cd frontend/
$ npm run serve
-> http://localhost:8080
```

動画の保存処理を行う場合は、Youtube APIキーを `.env`で設定していただく必要があります。

```
backend/.env
YOUTUBE_API_KEY=xxx
```