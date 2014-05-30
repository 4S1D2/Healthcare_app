class FavoritesController < ApplicationController
  before_action :load_favorite, only: [:show, :edit, :update, :destroy]


  def index
    @user = User.find(current_user)
    @favorites = @user.favorites
  end

  def new
    @favorite = Favorite.new
  end

  def create
    @hospital = Hospital.new(hospital_params)
    @hospital.address = params[:data][:address_1]
    @hospital.zip_code = params[:data][:zip_code]
    @hospital.phone = params[:data][:phone_number][:phone_number]
    @hospital.save
    @favorite = Favorite.create(id: @hospital.id, user_id: current_user.id)
    redirect_to user_favorites_path(current_user)
  end

  def destroy
    @favorite.destroy
    redirect_to user_favorites_path(current_user)
  end

  private

  def hospital_params
    params.require(:data).permit(:id, :hospital_name, :address, :city, :state, :zip_code, :phone, :score, :measure)
  end

  def load_favorite
    return @favorite = Favorite.find(params[:id])
  end
end
