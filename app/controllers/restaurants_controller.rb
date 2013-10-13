class RestaurantsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]

  def new
    redirect_to root_path unless current_user.role =='owner'
    @restaurant = Restaurant.new
    @restaurant.locations.build
  end

  def create
    redirect_to root_path unless current_user.role == 'owner'
    @restaurant = Restaurant.new( restaurant_params )
    @restaurant.user = current_user

    if @restaurant.save
      redirect_to user_path( current_user ), notice: 'Restaurant Created'
    else
      render :new
    end

  end

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find( params[:id] )
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name,
      locations_attributes: [:street, :city, :state]
    )
  end

end
