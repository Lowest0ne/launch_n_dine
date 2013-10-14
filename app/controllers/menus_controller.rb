class MenusController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def new
    redirect_to root_path unless current_user.id == params[:user_id].to_i
    @menu = Menu.new
  end

  def index
    @restaurant = Restaurant.find( params[:restaurant_id] )
    redirect_to root_path unless @restaurant.user == current_user
    @menus = @restaurant.menus
    @menu = Menu.new
  end

  def create
    @restaurant = Restaurant.find( params[:restaurant_id] )
    @menus = @restaurant.menus
    @menu = @menus.build( menu_params )
    if @menu.save
      redirect_to restaurant_menus_path( @restaurant ),  notice: 'Menu Added'
    else
      render :index
    end
  end

  def show
    @menu = Menu.find( params[:id] )
  end

  def menu_params
    params.require(:menu).permit( :name )
  end

end
