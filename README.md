# README

## users

|Column-------------|Type---|Options------|
|nickname-----------|string-|null: false--|
|email--------------|string-|unique: true-|
|encrypted_password-|string-|null: false--|
|first_name_kanji---|string-|null: false--|
|last_name_kanji----|string-|null: false--|
|first_name_kana----|string-|null: false--|
|last_name_kana-----|string-|null: false--|
|birth_day----------|date---|null: false--|


### Association
has_many :items
has_many :favorites
has_many :purchases

## items

|Column----------|Type-------|Options------------------------|
|name------------|string-----|null: false--------------------|
|image-----------|string-----|null: false--------------------|
|price-----------|integer----|null: false--------------------|
|condition-------|string-----|null: false--------------------|
|delivery_charge-|string-----|null: false--------------------|
|prefecture------|string-----|null: false--------------------|
|shipping_day----|string-----|null: false--------------------|
|user_id---------|references-|null: false, foreign_key: true-|
|category_id-----|references-|null: false, foreign_key: true-|
|favorite_id-----|references-|null: false, foreign_key: true-|
|brand_id--------|references-|null: false, foreign_key: true-|



### Association
belongs_to :user
has_many :favorites
has_one :purchase
has_one :purchase
belongs_to :category
belongs_to :brand

## shipping address

|Column----------|Type---|Options-----|
|post_code-------|string-|null: false-|
|prefecture------|string-|null: false-|
|city------------|string-|null: false-|
|street_address--|string-|null: false-|
|building--------|string-|------------|
|phone_number----|string-|null: false-|


### Association
belongs_to :item

## purchase

|Column--|Type-------|Options------------------------|
|user_id-|references-|null: false, foreign_key: true-|
|item_id-|references-|null: false, foreign_key: true-|


### Association
belongs_to :user
belongs_to :item

## favorites

|Column--|Type-------|Options------------------------|
|user_id-|references-|null: false, foreign_key: true-|
|item_id-|references-|null: false, foreign_key: true-|


### Association
belongs_to :user
belongs_to :item

## categories

|Column--|Type-------|Options------------------------|
|name----|string-----|null: false,unique: true-------|
|item_id-|references-|null: false, foreign_key: true-|


### Association
has_many :items

## brands

|Column--|Type-------|Options------------------------|
|name----|string-----|null: false,unique: true-------|
|item_id-|references-|null: false, foreign_key: true-|


### Association
has_many :items