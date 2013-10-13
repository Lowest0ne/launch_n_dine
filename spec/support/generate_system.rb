require 'spec_helper'

def generate_system

  owner = FactoryGirl.create(:owner)
  customer = FactoryGirl.create(:user)
  driver = FactoryGirl.create(:driver)


  5.times do

    menu_item = MenuItem.all.sample
    customer = User.where( role: 'customer').sample
    restaurant = menu_item.menu.restaurant

    order = Order.new( customer: customer, restaurant: restaurant )
    order.order_items.build( menu_item: menu_item )

    order.save
  end

end
