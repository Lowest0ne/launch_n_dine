class MenuItemsController < ApplicationController

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

  def menu_item_params
    params.require(:menu_item).permit(:name, :description, :price)
  end

end
