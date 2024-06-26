# テーブル設計

## users テーブル

| Column | Type   | Options               |
| ------ | ------ | --------------------- |
| nickname  | string | null: false |
| email  | string | null: false, unique: true |
| encrypted_password | string | null: false |
| lastname | string | null: false |
| firstname | string | null: false |
| lastname_kana | string | null: false |
| firstname_kana | string | null: false |
| birthday | date | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| title   | string | null: false |
| description   | text | null: false |
| category_id    | integer | null: false |
| condition_id    | integer | null: false |
| shipping_fee_bearer_id    | integer | null: false |
| prefecture_id    | integer | null: false |
| shipping_delivery_time_id    | integer | null: false |
| price   | integer | null: false |
| user   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| item   | references | null: false, foreign_key: true |
| user   | references | null: false, foreign_key: true |
| purchase_id  | references | null: false, foreign_key: true |


### Association

- belongs_to :item
- belongs_to :user  
- has_one :shipping_address

## shipping_address テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| zip_code   | string | null: false |
| prefecture_id   | integer | null: false |
| municipalities   | string | null: false |
| street_address   | string | null: false |
| building_name   | string |  |
| telephone_number   | string | null: false |
| purchase  | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase