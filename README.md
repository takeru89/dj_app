<img width="378" alt="app_name" src="https://user-images.githubusercontent.com/68336848/92458758-cbb85b00-f200-11ea-9add-66e56a3eaf85.png">

## 1. 概要

 Dict Japonicus（ディクト・ジャポニクス）は、日本語学習者向けの投稿型日本語辞書アプリです。
 
<br>

## 2. URL & Basic認証

 URL : https://www.dict-japonicus.com  
 ID : admin  
 PW : 8106
 
 <br>
 
## 3. テスト用アカウント

 EMAIL : sample@sample.com  
 PW : sample2020
 
 <br>

## 4. 実装機能
- ユーザー管理機能（devise）
- 語彙投稿一覧表示機能: トップページ（jquery plugin）
- 語彙詳細表示機能
- 語彙編集機能
- 語彙削除機能
- 語彙投稿機能（Active Hash, Active Storage）※画像はS3に保存
- 語彙検索機能
- マイ投稿一覧表示機能
- お気に入り登録・解除機能（jquery）
- お気に入り一覧表示機能
- ソート機能
- csv出力機能
- リクエスト機能（Javascript）
- 注目語彙表示機能（Swiper）
- ページネーション（kaminari）
- モデル単体テスト（RSpec）
- コード整形（Rubocop）
- デプロイ（EC2, Route53, ACM, ELB, Capistrano）

 <br>

## 5. 目的
- 欧米系の日本語学習者に、分かりやすく、実用的な語彙の説明が載った日本語辞書アプリを提供すること  
- 日本語教師が、語彙説明を練習・共有したり、語彙の授業で活用できるツールを提供すること

 <br>

## 6. 使用方法

### 未ログインユーザー
語彙の検索と語彙詳細閲覧のみできます。

### ログインユーザー
語彙の検索・詳細閲覧に加え、語彙ページの投稿、まだ投稿されていない語彙のリクエスト、語彙のお気に入り登録、お気に入りのcsv書き出しができます。  
学習者の方は、調べたい語彙がまだ投稿されていなければ、リクエストボードに投稿できます。また、お気に入り登録した語彙をcsvで書き出し、excelで整形したり、他のフラッシュカードアプリなどにインポートできます。  
日本語教師の方は、自分の語彙の教え方を投稿したり、他の先生の教え方を閲覧できます。お気に入り登録した語彙を、授業で映し出して利用することもできます。授業でクラス用のアカウントを作成し、学生に課題として語彙ページを投稿してもらえば、それをクラス内で共有できます。

 <br>

## 7. デモ

### 1) トップページ
・未ログイン時

![top](https://user-images.githubusercontent.com/68336848/92472474-7c7c2580-f214-11ea-804a-ca30cbfb60fe.png)

・ログイン時

![top_login](https://user-images.githubusercontent.com/68336848/92472499-830a9d00-f214-11ea-8108-0d9df5ac1e0f.png)

### 2) タグクラウド
投稿された語彙の、新しい順に100個抽出してtag cloudにしています。  
語彙をクリックすると詳細ページへ遷移します。

![tagcloud](https://user-images.githubusercontent.com/68336848/92472946-1a6ff000-f215-11ea-8c31-ae401ae7eb28.gif)

### 3) リクエスト & 注目語彙
リクエストは非同期で投稿できます。不適切な投稿内容抑止のため、削除機能はつけていません。  
注目語彙は、画像付きで投稿されたものの中からランダムで5つ選ばれています。

![request_spotlight](https://user-images.githubusercontent.com/68336848/92472990-25c31b80-f215-11ea-99d4-13215ec8aca3.gif)

### 4) 語彙検索機能
検索条件は、前方一致（デフォルト）、後方一致、部分一致、完全一致から選択できます。  
検索語彙入力箇所は、ひらがな、カタカナ、漢字、英語のどれでも検索できます。

![search](https://user-images.githubusercontent.com/68336848/92474958-99febe80-f217-11ea-89fb-3b7a610a5138.gif)

### 5) 語彙詳細表示機能
詳細画面下部には、直前のページに戻るボタンがあります。

![show](https://user-images.githubusercontent.com/68336848/92476390-d501f180-f219-11ea-9692-e1fcad6c21c9.gif)

### 6) 語彙投稿機能
語彙投稿ボタンはヘッダーにあるため、登録・ログイン画面以外の全てのページから可能です。  
投稿後は、マイ投稿一覧ページに遷移します。

![post](https://user-images.githubusercontent.com/68336848/92474299-90288b80-f216-11ea-8748-a1871c16cedb.gif)

### 7) 語彙編集機能
編集画面は、自身の投稿の詳細画面と、検索結果、マイ投稿一覧からも遷移できます。  
編集ボタンクリック後は、詳細画面に遷移します。  
編集後の詳細画面の下部には、ホームとマイ投稿ページへのボタンが出ます。

![edit](https://user-images.githubusercontent.com/68336848/92477302-560db880-f21b-11ea-9084-81b8abab0f00.gif)

### 8) 語彙削除機能
削除後は、マイ投稿一覧ページへ遷移します。

![delete](https://user-images.githubusercontent.com/68336848/92476725-61141900-f21a-11ea-9a2e-8b3ba459277d.gif)

### 9) お気に入り機能
お気に入り登録は、語彙詳細ページと、検索結果、マイ投稿一覧からもできます。
お気に入り解除は、上記に加え、お気に入り一覧からも解除できます。

![favorites](https://user-images.githubusercontent.com/68336848/92479069-08467f80-f21e-11ea-834e-6e36ab6503a6.gif)

![fav_delete](https://user-images.githubusercontent.com/68336848/92479239-40e65900-f21e-11ea-9f8e-f08162a61ffe.gif)

### 10) ソート機能
マイ投稿一覧と、お気に入り一覧で並び替えができます。  
並び替え条件は、新旧の昇順・降順、五十音の昇順・降順の4種類です。

![sort](https://user-images.githubusercontent.com/68336848/92479300-53f92900-f21e-11ea-9c84-609570680684.gif)

### 11) csv出力機能
![csv](https://user-images.githubusercontent.com/68336848/92479262-493e9400-f21e-11ea-8db1-6c94f94303dd.gif)

### 12) レスポンシブ対応
スマートフォンの画面サイズにも対応するようにしました。

<table>
  <tr>
    <td align="center">トップ</td>
    <td align="center">一覧</td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/68336848/92480326-b4d53100-f21f-11ea-9fff-dbf736620b12.png" width="400px"></td>
    <td valign="top"><img src="https://user-images.githubusercontent.com/68336848/92480348-bbfc3f00-f21f-11ea-9470-70572fe8aa56.png" width="400px" ></td>
  </tr>
</table>

 <br>
 
## 8. データベース設計

### ER図  

![dj_er](https://user-images.githubusercontent.com/68336848/92459839-243c2800-f202-11ea-9a41-86b5a71007ec.png)

### テーブル設計  

#### users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| name     | string | null: false |
| email    | string | null: false |
| password | string | null: false |

#### Association

- has_many :words
- has_many :likes
- has_many :requests


#### words テーブル

| Column        | Type       | Options                        |
| ------------- | ---------  | -----------------------------  |
| user          | references | null: false, foreign_key: true |
| kana          | string     | null: false                    |
| kanji         | string     |
| english       | string     | null: false                    |
| word_class_id | integer    | null: false                    |
| explanation   | text       | null: false                    |

#### Association

- belongs_to :user
- has_many :likes


#### favorites テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| word   | references | null: false, foreign_key: true |

#### Association

- belongs_to :user
- belongs_to :word


#### requests テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user ------- | references | null: false, foreign_key: true |
| request_word | string     | null: false                    |

#### Association

- belongs_to :user

 <br>

## 9. ローカルでの動作方法

### バージョン
Ruby on Rails 6.0.0  
MySQL 14.14

### コマンド

```
$ git clone https://github.com/takeru89/dj_app.git
$ cd dj_app
$ bundle install
$ rails db:migrate
$ rails s
```
