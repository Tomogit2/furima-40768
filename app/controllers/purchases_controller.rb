class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:new, :create]

  def new
    @purchase_address = PurchaseAddress.new
  end

  if @purchase_address.valid?
    @purchase_address.save
    return redirect_to root_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def purchase_address_params
    params.require(:purchase_address).permit(:user_id, :item_id, :zip_code, :prefecture_id, :municipalities, :street_address, :building_name, :telephone_number, :token)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end