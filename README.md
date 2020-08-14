# テーブル設計

## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| name     | string | null: false |
| email    | string | null: false |
| password | string | null: false |

### Association

- has_many :words
- has_many :likes

## words テーブル

| Column      | Type       | Options                        |
| ----------- | ---------  | -----------------------------  |
| user        | references | null: false, foreign_key: true |
| kana        | string     | null: false                    |
| kanji       | string     |
| english     | string     | null: false                    |
| pos         | integer    | null: false                    |
| explanation | text       | null: false                    |

### Association

- belongs_to :user
- has_many :likes

## likes テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references |
| word   | references |

### Association

- belongs_to :user
- belongs_to :word