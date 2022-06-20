class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: :index
  def index
    @item = Item.find(params[:item_id])
    if @item.purchase.blank? && current_user.id != @item.user.id
      @formob = Formob.new
    else
      redirect_to root_path
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @formob = Formob.new(formob_params)
    if @formob.valid? 
      pay_item
      @formob.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def formob_params
    params.require(:formob).permit(:post_code, :prefecture_id, :city, :street_address, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: formob_params[:token],
      currency: 'jpy'
    )
  end
end