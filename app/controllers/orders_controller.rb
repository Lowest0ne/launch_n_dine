class OrdersController < ApplicationController
  before_filter :authenticate_user!, only: [:index]

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

  def index
    if !current_user || current_user.role == 'customer'
      redirect_to root_path
    elsif params[:restaurant_id]
      @restaurant = Restaurant.find(params[:restaurant_id])
      redirect_to root_path if current_user.role == 'owner' && @restaurant.user != current_user
      @orders = Order.where( restaurant: @restaurant )
    else
      @orders = Order.all
    end

  end

  protected
  def order_params
    params.require(:order).permit( order_items_attributes: [:menu_item_id] )
  end

end
