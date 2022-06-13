# README

## users

|Column             |Type   |Options                  |
|-------------------|-------|-------------------------|
|nickname           |string |null: false              |
|email              |string |unique: true,null: false |
|encrypted_password |string |null: false              |
|first_name_kanji   |string |null: false              |
|last_name_kanji    |string |null: false              |
|first_name_kana    |string |null: false              |
|last_name_kana     |string |null: false              |
|birth_day          |date   |null: false              |


### Association
has_many :items
<!--has_many :favorites-->
has_many :purchases

## items

|Column             |Type       |Options                        |
|-------------------|-----------|-------------------------------|
|name               |string     |null: false                    |
|explanation        |text       |null: false                    |
|price              |integer    |null: false                    |
|condition_id       |integer    |null: false                    |
|delivery_charge_id |integer    |null: false                    |
|prefecture_id      |integer    |null: false                    |
|shipping_day_id    |integer    |null: false                    |
|category_id        |integer    |null: false                    |
|user               |references |null: false, foreign_key: true |
<!--|category        |references |null: false, foreign_key: true |-->
<!--|favorite        |references |null: false, foreign_key: true |-->
<!--|brand           |references |null: false, foreign_key: true |-->

### Association
belongs_to :user
has_one :purchase
<!--has_many :favorites-->
<!--belongs_to :category-->
<!--belongs_to :brand-->

## shipping addresses

|Column          |Type        |Options                        |
|----------------|------------|-------------------------------|
|post_code       |string      |null: false                    |
|prefecture_id   |integer     |null: false                    |
|city            |string      |null: false                    |
|street_address  |string      |null: false                    |
|building        |string      |                               |
|phone_number    |string      |null: false                    |
|purchase        |references  |null: false, foreign_key: true |


### Association
belongs_to :purchase

## purchases

|Column              |Type       |Options                        |
|--------------------|-----------|-------------------------------|
|user                |references |null: false, foreign_key: true |
|item                |references |null: false, foreign_key: true |


### Association
belongs_to :user
belongs_to :item
has_one :shipping_address

<!--## favorites

|Column  |Type       |Options                        |
|--------|-----------|-------------------------------|
|user    |references |null: false, foreign_key: true |
|item    |references |null: false, foreign_key: true |


### Association
belongs_to :user
belongs_to :item-->

<!--## categories

|Column  |Type       |Options                        |
|--------|-----------|-------------------------------|
|name    |string     |null: false,unique: true       |
|item    |references |foreign_key: true              |


### Association
has_many :items-->

<!--## brands

|Column  |Type       |Options                        |
|--------|-----------|-------------------------------|
|name    |string     |null: false,unique: true       |
|item    |references |foreign_key: true              |


### Association
has_many :items-->