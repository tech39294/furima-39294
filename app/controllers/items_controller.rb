class ItemsController < ApplicationController
  before_action :authenticate_user!
  def index
    # @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
  
    if @item.save
      # 保存に成功した場合の処理
      redirect_to root_path
    else
      # 保存に失敗した場合の処理
      render :new
    end
  end
  private

  def item_params
    params.require(:item).permit(:image, :item_name, :item_text, :category_id, :item_status_id, :delivery_charge_id,:delivery_area_id, :delivery_time_id, :price).merge(user_id: current_user.id)
  end


end
