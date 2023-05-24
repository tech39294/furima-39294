class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :restrict_access, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_address_params
    params.require(:order_address).permit(:postal_code, :delivery_area_id, :city, :street_address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  
      card: order_address_params[:token],   
      currency: 'jpy'                
    )
  end

  def restrict_access
    if current_user == @item.user || @item.sold_out?
      redirect_to root_path
    end
  end

end
