class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.order('created_at DESC')
  end

  #こちらは詳細機能での実装内容。
  #こちらのプルリクエスト内容をマージしてしまうと、次回の実装で変更点として上がらず、レビューができなくなってしまうため一度コメントアウト。
  #def show
    #@item = Item.find(params[:id])
  #end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: 'Item was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :category_id, :condition_id, :shipping_fee_bearer_id, :prefecture_id,
                                 :shipping_delivery_time_id, :price, :image).merge(user_id: current_user.id)
  end
end
