class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :delivery_area
  belongs_to :delivery_charge
  belongs_to :delivery_time
  belongs_to :item_status

  # 空の投稿を保存できないようにする
  validates :item_name, :item_text, :category, :delivery_area, :delivery_charge, :delivery_time, :item_status, :price,
            presence: true
  validates :image, presence: true

  # ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_area_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_charge_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_time_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :item_status_id, numericality: { other_than: 1, message: "can't be blank" }

  # 価格は、¥300~¥9,999,999の間のみ保存可能であること。
  # 価格は半角数値のみ保存可能であること。
  validates :price,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                            message: 'must be a number between ¥300 and ¥9,999,999' }
end
