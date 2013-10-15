class RestaurantsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]
  before_filter :authenticate_owner, except: [:show, :index]
  before_filter :authenticate_create, only: [:new, :create]

  def authenticate_owner
    redirect_to root_path unless current_user.is_owner?
  end

  def authenticate_create
    redirect_to root_path unless current_user.id == params[:user_id].to_i
  end

  def new
    @restaurant = Restaurant.new
    @restaurant.locations.build
  end

  def create
    @restaurant = Restaurant.new( restaurant_params )
    @restaurant.user = current_user

    if @restaurant.save
      redirect_to restaurant_path( @restaurant ), notice: 'Restaurant Created'
    else
      render :new
    end

  end

  def index
    if current_user && current_user.is_owner?
      @restaurants = Restaurant.where( user: current_user )
    elsif current_user && current_user.is_driver?
      @restaurants = Restaurant.all
    else
      @restaurants = Restaurant.all
    end
  end

  def show
    @restaurant = Restaurant.find( params[:id] )
  end

  def edit
    @restaurant = Restaurant.find( params[:id] )
    redirect_to root_path unless @restaurant.user == current_user
  end

  def update

    @restaurant = Restaurant.find( params[:id] )
    redirect_to root_path unless @restaurant.user == current_user
    if @restaurant.update( restaurant_params )
      redirect_to @restaurant, notice: 'Restaurant Updated'
    else
      render :edit
    end
  end

  def destroy
    @restaurant = Restaurant.find( params[:id] )
    if @restaurant.user == current_user
      @restaurant.destroy
      redirect_to restaurants_path, notice: 'Restaurant Deleted'
    else
      redirect_to root_path
    end

  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name,
      locations_attributes: [:id, :street, :city, :state]
    )
  end

end
