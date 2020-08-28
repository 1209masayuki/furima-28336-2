class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set, only: [:show, :edit]

  def show
  end

  def edit
  end

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to action: :index
    else
      render 'new'
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to action: :show
    else
      render 'edit'
    end
  end

  # ここ
  def destroy
    item = Item.find(params[:id])
    return redirect_to action: :index if item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :image, :info, :price, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id).merge(user_id: current_user.id)
  end
  
  def set
    @item = Item.find(params[:id])
  end
end
