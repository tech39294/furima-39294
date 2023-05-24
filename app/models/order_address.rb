class OrderAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postal_code, :delivery_area_id, :city, :street_address, :building, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :delivery_area_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city
    validates :street_address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid." }
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(order_id: order.id, postal_code: postal_code, delivery_area_id: delivery_area_id, city: city, street_address: street_address, building: building, phone_number: phone_number)
  end
end