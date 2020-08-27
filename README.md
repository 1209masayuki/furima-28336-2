# テーブル設計

## users テーブル

| Column          | Type    | Options     |
| --------------- | ------- | ----------- |
| nickname        | string  | null: false |
| email           | string  | null: false |
| password        | string  | null: false |
| first_name      | string  | null: false |
| last_name       | string  | null: false |
| first_name_kana | string  | null: false |
| last_name_kana  | string  | null: false |
| birth_date      | date    | null: false |

### Association

* has_many :purchases
* has_many :items

## items テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| name                   | string     | null: false                    |
| info                   | text       | null: false,                   |
| category_id            | integer    | null: false,                   |
| sales_status_id        | integer    | null: false,                   |
| shipping_fee_status_id | integer    | null: false,                   |
| prefecture_id          | integer    | null: false,                   |
| scheduled_delivery_id  | integer    | null: false,                   |
| price                  | integer    | null: false, index: true       |
| user                   | references | null: false, foreign_key: true |

### Association

* has_one :purchase
* belongs_to :user
* has_one_attached :image
* extend ActiveHash::Associations::ActiveRecordExtensions
* belongs_to_active_hash :category
* belongs_to_active_hash :sales_status
* belongs_to_active_hash :shipping_fee_status
* belongs_to_active_hash :prefecture
* belongs_to_active_hash :scheduled_delivery

## buyers テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false, default: "",      |
| prefecture_id | integer    | null: false,                   |
| city          | string     | null: false, default: "",      |
| addresses     | string     | null: false, default: ""       |
| building      | string     |              default: ""       |
| phone_num     | string     | null: false, default: ""       |
| purchase_id   | references | null: false, foreign_kye: true |

### Association

* extend ActiveHash::Associations::ActiveRecordExtensions
* belongs_to_active_hash :prefecture
* belongs_to :purchase

## purchases テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

* belongs_to :item
* belongs_to :user
* has_one    :buyer
