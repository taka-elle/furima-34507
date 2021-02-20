class ManagementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_index

  def index
    @management_address = ManagementAddress.new
  end

  def create
    @management_address = ManagementAddress.new(management_params)
    if @management_address.valid?
      pay_item
      @management_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def management_params
    params.require(:management_address).permit(:add_num, :area_id, :city, :add_line, :add_build, :tel_num).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    redirect_to root_path if current_user.id == @item.user_id || !@item.management.blank?
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: management_params[:token],
      currency: 'jpy'
    )
  end
end
