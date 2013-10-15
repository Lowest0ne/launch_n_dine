class MenuItemsController < ApplicationController

  before_filter :authenticate_user!, except: [ :show, :index ]

  def index
    @menu = Menu.find( params[:menu_id])
    @menu_items = @menu.menu_items
    @menu_item = MenuItem.new
  end

  def create
    @menu = Menu.find( params[:menu_id])
    @menu_items = @menu.menu_items
    @menu_item = @menu.menu_items.new( menu_item_params )

    if @menu_item.save
      redirect_to menu_menu_items_path(@menu), notice: 'Menu Item Added'
    else
      render :index
    end
  end

  def edit
    @menu_item = MenuItem.find( params[:id] )
    redirect_to root_path unless @menu_item.menu.restaurant.user == current_user
  end

  def update
    @menu_item = MenuItem.find( params[:id] )
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
    @menu_item = MenuItem.find( params[:id] )
    if current_user != @menu_item.menu.restaurant.user
      redirect_to root_path
    else
      @menu_item.destroy
      redirect_to menu_menu_items_path( @menu_item.menu ),
        notice: 'Menu Item Deleted'
    end
  end


  def menu_item_params
    params.require(:menu_item).permit(:name, :description, :price)
  end

end
