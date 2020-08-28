class BuyersController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id
    @buyerpurchase = BuyerPurchase.new
  end

  def create
    @buyerpurchase = BuyerPurchase.new(buyer_params)

    if @buyerpurchase.valid?
      pay_item
      @buyerpurchase.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render 'index'
    end
  end

  protected

  def buyer_params
    item = Item.find(params[:item_id])
    params.require(:buyer_purchase).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_num, :purchase_id).merge(user_id: current_user.id, item_id: item.id)
  end

  # def token_params
  #   params.permit(:token)
  # end

  def pay_item
    @item = Item.find(params[:item_id])
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end
end
