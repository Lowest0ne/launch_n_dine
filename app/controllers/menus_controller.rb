class MenusController < ApplicationController

  def new
    @menu = Menu.new
  end

  def index
    @restaurant = Restaurant.find( params[:restaurant_id] )
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
