class MenuItemsController < ApplicationController

  before_filter :find_menu, only:   [:new, :create, :index ]
  before_filter :find_item, except: [:new, :create, :index ]

  before_filter :authenticate_user!, except: [ :show, :index ]

  def new
    @menu_item = MenuItem.new
  end

  def index
    @menu_items = @menu.menu_items
  end

  def show
  end

  def create
    @menu_item = @menu.menu_items.new( menu_item_params )
    @menu_item.menu = @menu

    if @menu_item.save
      redirect_to menu_item_path(@menu_item), notice: 'Menu Item Added'
    else
      render :new
    end
  end

  def edit
    redirect_to root_path unless @menu_item.menu.restaurant.user == current_user
  end

  def update
    if current_user != @menu_item.menu.restaurant.user
      redirect_to root_path
    elsif @menu_item.update( menu_item_params )
      redirect_to menu_menu_items_path( @menu_item.menu ),
        notice: 'Menu Item Updated'
    else
      render :edit
    end
  end

  def destroy
    if current_user != @menu_item.menu.restaurant.user
      redirect_to root_path
    else
      @menu_item.destroy
      redirect_to menu_menu_items_path( @menu_item.menu ),
        notice: 'Menu Item Deleted'
    end
  end

  protected

  def find_item
    @menu_item = MenuItem.find( params[:id] )
  end

  def find_menu
    @menu = Menu.find( params[ :menu_id ] )
  end

  def menu_item_params
    params.require(:menu_item).permit(:name, :description, :price)
  end

end
