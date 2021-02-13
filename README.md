# テーブル設計

## users テーブル

| Column             | Type   | Option                    |
| ------------------ | ------ | ------------------------- |
| nickname           | string	| null: false               |
| emaie              | string | null: false, unique: true |
| encrypted_password | string	| null: false               |
| last_name          | string | null: false               |
| first_name         | string	| null: false               |
| last_name_f        | string | null: false               |
| first_name_f       | string	| null: false               |
| birthday           |date    | null: false               |

### Association
- has_many :items
- has_many :managements

## items テーブル
| Column       | Type       | Option                          |
| ------------ | ---------- | ------------------------------- |
| name         | string     | null: false                     |
| text         | text       | null: false                     |
| category_id  | integer    | null: false                     |
| status_id    | integer    | null: false                     |
| s_charges_id | integer    | null: false                     |
| s_area_id    | integer    | null: false                     |
| s_day_id     | integer    | null: false                     |
| price        | integer    | null: false                     |
| user         | references | null: false , foreign_key: true |

### Association
- belongs_to :user
- has_one :management

# Managements テーブル
| Column | Type       | Option                          |
| ------ | ---------- | ------------------------------- |
| user   | references | null: false , foreign_key: true |
| item   | references | null: false , foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :Addresses

## Addresses テーブル
| Column     | Type       | Option                          |
| ---------- | ---------- | ------------------------------- |
| add_num    | string     | null: false                     |
| region_id  | integer    | null: false                     |
| city       | string     | null: false                     |
| add_line   | string     | null: false                     |
| add_build  | string     |                                 |
| tel_num    | string     | null: false                     |
| management | references | null: false , foreign_key: true |

### Association
- belongs_to :management