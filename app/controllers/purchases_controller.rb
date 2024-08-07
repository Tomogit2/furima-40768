class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:new, :create]
  before_action :redirect_unless_user, only: [:new, :create]
  before_action :set_payjp_api_key, only: [:create]
  
  def new    
    @purchase_address = PurchaseAddress.new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    if @item.purchase.present? || current_user.id == @item.user.id
      redirect_to root_path
    end
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_address_params)

    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      Rails.logger.error @purchase_address.errors.full_messages.join(", ")
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render 'new', status: :unprocessable_entity
    end
  end

  def pay_item
    Payjp::Charge.create(
      amount: @item.price, # 購入する商品の価格を指定
      card: params[:token], # カードトークンを指定
      currency: 'jpy' # 通貨の種類（日本円）を指定
    )
  end

  private
  
  def set_payjp_api_key
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
  end

  def purchase_address_params
    params.require(:purchase_address).permit(:zip_code, :prefecture_id, :municipalities, :street_address, :building_name,
                                             :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_unless_user
    return if current_user.id != @item.user.id

    redirect_to root_path
  end
end

