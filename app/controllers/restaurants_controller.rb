class RestaurantsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]

  before_filter :find_restaurant, except: [:new, :create, :index ]
  before_filter :find_user,         only: [:new, :create, :index ]

  def new
    redirect_to root_path unless @user.role == 'owner'
    @restaurant = Restaurant.new
    @restaurant.locations.build
  end

  def create
    redirect_to root_path unless @user.role == 'owner'
    @restaurant = @user.restaurants.new( restaurant_params )

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
  end

  def edit
    redirect_to root_path unless @restaurant.user == current_user
  end

  def update
    if @restaurant.user != current_user
      redirect_to root_path
    elsif @restaurant.update( restaurant_params )
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

  protected

  def restaurant_params
    params.require(:restaurant).permit(:name,
      locations_attributes: [:id, :street, :city, :state]
    )
  end

  def authenticate_create
  end

  def find_restaurant
    @restaurant = Restaurant.find( params[:id] )
  end

  def find_user
    @user = User.find( params[:user_id ] )
  end

end
