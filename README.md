# テーブル設計

## users テーブル

| Column | Type   | Options               |
| ------ | ------ | --------------------- |
| nickname  | string | null: false, unique: true |
| email  | string | null: false, unique: true |
| encrypted_password | string | null: false |
| fullname | string | null: false |
| fullname_kana | string | null: false |
| birthday | string | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| image   | text | null: false |
| title   | string | null: false |
| description   | text | null: false |
| category   | string | null: false |
| condition   | string | null: false |
| shipping_fee_bearer   | string | null: false |
| shipping_region   | string | null: false |
| shipping_delivery_time   | string | null: false |
| price   | string | null: false |
| user_id   | references | null: false, foreign_key: true |
| purchases_id   | references | foreign_key: true |

### Association

- belongs_to :user
- has_one :purchases

## purchases テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| shipping address   | text | null: false |
| item_id   | references | null: false, foreign_key: true |
| user_id   | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user