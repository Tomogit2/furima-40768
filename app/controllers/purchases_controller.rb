class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:new, :create]
  before_action :redirect_unless_user, only: [:new, :create]

  def new
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_address_params.merge(user_id: current_user.id, item_id: params[:item_id]))
    if @purchase_address.valid?
      @purchase_address.save
      return redirect_to root_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

private

  def purchase_address_params
    params.require(:purchase_address).permit(:zip_code, :prefecture_id, :municipalities, :street_address, :building_name, :telephone_number, :token)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_unless_user
    return if current_user.id != @item.user.id
    redirect_to root_path
  end
end