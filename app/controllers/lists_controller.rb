class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def index
    @lists = current_user.lists
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
    @gifts = Gift.where(list_id: params[:id])
    @gift = Gift.new
    @users = @list.users.all.pluck(:username).sort.map{ |name| name.capitalize }
  end

  def new
    @list = List.new
  end

  def edit
  end

  def create
    @list = current_user.lists.create(name: list_params[:name])
    redirect_to lists_path
  end

  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @list.destroy
    redirect_to @list
  end

  private

    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:name, :user_id)
      # params.fetch(:list, {})
    end
end
