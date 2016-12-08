class GiftsController < ApplicationController
  before_action :set_constants, except: [:index, :new, :create]

  def index
    @gifts = Gift.all
  end

  def show
  end

  def new
    @gift = Gift.new
  end

  def create
    @list = List.find(1)
    requester = User.where(username: gift_params[:requester].downcase).first.id
    @gift = Gift.create!(name: gift_params[:name], requester_id: requester, list_id: 1)
    redirect_to @list
  end

  def update
    set_gift
    @gift.update(buyer_id: current_user.id )
    redirect_to @list
  end

  def destroy
    @gift.destroy
    redirect_to @list
  end

  def claim
    @gift.update(buyer_id: current_user.id)
    redirect_to list_path(@list.id)
  end

  def unclaim
    @gift.update(buyer_id: nil)
    redirect_to list_path(@list.id)
  end

  private

  def set_constants
    @gift = Gift.find(params[:id])
    @list = List.find(1)
  end

  def gift_params
    params.require(:gift).permit(:name, :requester)
    # params.fetch(:gift, {})
  end
end
