class MenusController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  before_filter :find_menu,     except: [:new, :create, :index ]
  before_filter :find_restaurant, only: [:new, :create, :index ]

  def new
    redirect_to root_path unless @restaurant.user == current_user
    @menu = Menu.new
  end

  def index
    @menus = @restaurant.menus
    @menu = Menu.new
  end

  def create
    @menu = @restaurant.menus.build( menu_params )
    if @menu.save
      redirect_to menu_path( @menu ),  notice: 'Menu Added'
    else
      render :index
    end
  end

  def show
  end

  def edit
    @restaurant = @menu.restaurant
    redirect_to root_path unless @restaurant.user == current_user
  end

  def update
    if current_user != @menu.restaurant.user
      redirect_to root_path
    elsif @menu.update( menu_params )
      redirect_to menu_path( @menu ), notice: 'Menu Updated'
    else
      render :edit
    end
  end

  def destroy
    if @menu.restaurant.user == current_user
      @menu.destroy
      redirect_to restaurant_menus_path( @menu.restaurant ),
                  notice: 'Menu Deleted'
    else
      redirect_to root_path
    end
  end

  protected

  def menu_params
    params.require(:menu).permit( :name )
  end

  def find_menu
    @menu = Menu.find( params[:id] )
  end

  def find_restaurant
    @restaurant = Restaurant.find( params[:restaurant_id] )
  end

end
