require 'spec_helper'

def sign_in user
  visit root_path
  click_link 'Sign In'
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Sign In'
  user
end

def create_signed_in( factory )
  resource = FactoryGirl.create( factory )
  sign_in(resource)
end

def create_pool

  pool = {}
  pool[:owner] = FactoryGirl.create(:owner)
  pool[:restaurant] = FactoryGirl.create(:restaurant, user: pool[:owner])
  pool[:menu] = FactoryGirl.create(:menu, restaurant: pool[:restaurant])
  pool[:menu_item] = FactoryGirl.create(:menu_item, menu: pool[:menu])
  pool[:customer] = FactoryGirl.create(:customer)
  pool[:driver] = FactoryGirl.create(:driver)

  pool
end

def create_order( customer, restaurant, state = 'requested' )
  order = Order.new( customer: customer, restaurant: restaurant, state: state )
  order.order_items.build( menu_item: restaurant.menus.first.menu_items.first )
  order.save
  order
end
