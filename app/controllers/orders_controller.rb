class OrdersController < ApplicationController
  before_filter :authenticate_user!, only: [:index]

  def new
    redirect_to new_user_location_path( current_user ) if current_user.locations.empty?
    @menu = Menu.find( params[:menu_id] )
    @order = Order.new
    @order.order_items.build
  end

  def create
    redirect_to new_user_location_path( current_user ) if current_user.locations.empty?
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
    case current_user.role
    when 'driver'
      if params[:view] == 'free'
        @orders = Order.where( "state = ? or state = ?", 'requested', 'confirmed' )
      else
        @orders = Order.where( driver: current_user ).where( "state != 'canceled'" )
      end
    when 'customer'
      redirect_to new_user_location_path( current_user ) if current_user.locations.empty?
      @orders = current_user.purchases
    when 'owner'
      @orders = current_user.restaurants.map{ |r| r.orders }.flatten
    end
  end

  protected
  def order_params
    params.require(:order).permit( order_items_attributes: [:menu_item_id] )
  end

end
