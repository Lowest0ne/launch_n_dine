class OrdersController < ApplicationController

  def new
    @menu = Menu.find( params[:menu_id] )
    @order = Order.new
    @order.order_items.build
  end

  def create
    @menu = Menu.find( params[:menu_id] )
    @order = Order.new( order_params )
    @order.customer = current_user
    @order.restaurant = Restaurant.find( @menu.restaurant )

    if @order.save
      redirect_to order_path(@order), notice: 'Order has been created'
    else
      render :new
    end
  end

  def show
    @order = Order.find( params[:id] )
  end

  protected
  def order_params
    params.require(:order).permit( order_items_attributes: [:menu_item_id] )
  end

end
