class MenusController < ApplicationController

  def new
    @menu = Menu.new
  end

  def index
    @restaurant = Restaurant.find( params[:restaurant_id] )
    @menus = @restaurant.menus
    @new_menu = @restaurant.menus.build
  end

  def create
    current_user.restaurants.find( params[:restaurant_id] )
    @menu = Menu.new( menu_params )
    @menu.restaurant_id = params[:restaurant_id]
    if @menu.save
      redirect_to menu_path( @menu ),  notice: 'Menu Added'
    else
      render new_restaurant_menu_path( params[:restaurant_id] )
    end
  end

  def show
    @menu = Menu.find( params[:id] )
  end

  def menu_params
    params.require(:menu).permit( :name )
  end

end
