# workout-share
## 概要
筋トレに関する情報を共有するSNSです。  
個人のトレーニング記録として利用したり、他のユーザーのトレーニング報告に刺激を受けたり、  
最新の筋トレ情報をキャッチアップしたりなど使い方は様々です。

URL: https://workout-share.com

## 環境構築
1. まずはcloneしてください  
``` 
https://github.com/ta-mu-aa/workout-share.git 
```
2. .env.exampleの記載を参考に.envファイルを作成  
``` 
touch .env　
```
4. container imageを作成
``` 
docker-compose build　
```
5. DBの作成
``` 
 docker-compose run --rm api rails db:create 
```
6. DBのマイグレーション
``` 
 docker-compose run --rm api rails db:migrate 
```
7. コンテナの作成
 ``` 
 docker-compose up -d 
```
  ※ vite not foundが出た場合は以下を実行
 ``` 
 docker-compose run --rm front npm install
```

8. コンテナが起動したことを確認後  
`http://locahost:3000` にアクセス

#### テストデータを投入する場合
 ``` 
 docker-compose run --rm api rails db:seed
```

## インフラ構成図
![構成図](https://github.com/ta-mu-aa/workout-share/assets/76101803/c809c0f3-86ed-4da3-b966-7e4d3677f265)

## ER図
![ws-er-2](https://github.com/ta-mu-aa/workout-share/assets/76101803/60c508e8-8660-4ee2-9f6d-8d343870ccd3)

## 使用技術
#### フロントエンド
- フレームワーク
  - Vue.js 
- ビルド
  - Vite
- CSS関連
  - Tailwind CSS
- その他
  - Vuex, VueRouter, axios, etc..
#### バックエンド
- フレームワーク
  - Ruby on Rails
- DB
  - MySQL
#### インフラ
- docker, docker compose
- クラウドサービスはAWSを使用
  - ECR
  - ECS (Fargate)
  - ALB
  - RDS
  - S3
  - Route53
  - etc...
- 本番環境のみwebサーバーとしてNginxを利用

## その他
### こだわりポイント
- ログイン認証にJWTを使用
  - トークンをつかった認証をやってみたかった  
  - JWTを使ってみたかった
- tailwind CSSを使用
  - 流行っているらしいので使ってみたかった
  - 結構大変だったが、CSSは嫌いじゃないので○
- GithubActionsによるCI/CD
  - githubActionsを触ってみたかった
  - 自動テストと自動デプロイを作ってみたかった
  - インフラ周りに興味があった

### 今後について
機能がまだまだ少ないので独自の機能を入れていきたい  
マイページに自分の筋トレ記録をカレンダー表示できるなど
