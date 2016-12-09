class ListsController < ApplicationController
    before_action :set_list, only: [:show, :edit, :update, :destroy]

    def index
        @lists = []
        #   hack for Atwells to be removed
        if current_user.lists.present?
            @lists.push(current_user.lists)
        end

        if current_user.id < 12
            @lists.push(List.first)
        end

        @lists.flatten!

        @list = List.new
    end

    def show
        @list = List.find(params[:id])
        @gifts = Gift.where(list_id: params[:id]).sort
        @gift = Gift.new
        @users = User.all.pluck(:username).map{ |name| name.capitalize }.sort.sort
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
