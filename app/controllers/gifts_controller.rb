class GiftsController < ApplicationController
  before_action :set_constants, except: [:index, :new, :create]

  def index
    @gift = Gift.new

    @requested_gifts = [ ]
    @claimed_gifts = [ ]

    Gift.all.each do |gift|
        if gift.buyer_id == current_user.id
            @claimed_gifts.push(gift)
        elsif gift.created_by == current_user.id && gift.requester_id == current_user.id
            @requested_gifts.push(gift)
        end
    end
  end

  def show
  end

  def new
    @gift = Gift.new
  end

  def create
    @list = List.find(1)
    if gift_params[:requester].present?
        requester = User.where(username: gift_params[:requester].downcase).first
        create_gift( requester )
        redirect_to @list
    else
        requester = current_user
        create_gift( requester )
        redirect_to gifts_path
    end
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

  def create_gift requester
    @gift = Gift.create!(name: gift_params[:name], requester_id: requester.id, list_id: 1, created_by: current_user.id)
    end
end
