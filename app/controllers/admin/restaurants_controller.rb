class Admin::RestaurantsController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin

  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "restaurant was successfully create"
      redirect_to admin_restaurants_path
    else
      flash.now[:alert] = "restaurant was failed to create"
      render :new
    end
  end

  def show #可不用寫，為文字說明而保留
  end

  def edit #可不用謝，為文字說明而保留
  end

  def update
    if @restaurant.update(restaurant_params)
      flash[:notice] = "restaurant was successfully update"
      redirect_to admin_restaurant_path(@restaurant)
    else
      flash.now[:alert] = "restaurant was failed to update"
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to admin_restaurants_path
    flash[:alert] = "restaurant was deleted"
  end  


    private

    def restaurant_params
      params.require(:restaurant).permit(:name, :opening_hours, :tel, :address, :description)
    end

    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

end
