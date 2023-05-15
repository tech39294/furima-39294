# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| user_name          | string | null: false               |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| password           | string | null: false               |

### Association
- has_many :item
- has_many :order


## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| item_image         | text       | null: false                    |
| item_name          | string     | null: false                    |
| item_text          | string     | null: false                    |
| category           | string     | null: false                    |
| item_status        | string     | null: false                    |
| delivery_charge    | string     | null: false                    |
| delivery_area      | string     | null: false                    |
| delivery_time      | string     | null: false                    |
| price              | integer    | null: false                    |

### Association
- belongs_to :user
- has_one :order


## orders テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :adress

## addresses テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| order              | references | null: false, foreign_key: true |
| postal_code        | string     | null: false                    |
| prefecture         | string     | null: false                    |
| city               | string     | null: false                    |
| street_address     | string     | null: false                    |
| building           | string     | null: false                    |
| phone_number       | string     | null: false                    |

### Association
- belongs_to :order















