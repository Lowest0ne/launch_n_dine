require 'spec_helper'

feature 'driver views orders' do

  scenario 'it can be done' do

    customer = FactoryGirl.create(:customer)
    owner = FactoryGirl.create(:owner)
    restaurant = FactoryGirl.create(:restaurant, user: owner)
    menu = FactoryGirl.create(:menu, restaurant: restaurant)
    menu_item = FactoryGirl.create(:menu_item, menu: menu )

    order = Order.new( customer: customer, restaurant: restaurant)
    order.order_items.build( menu_item: menu_item )
    order.save

    expect( Order.count ).to_not eql(0)

    driver = create_signed_in(:driver)

    page.should have_content( restaurant.name )
    page.should have_content( restaurant.location.street )
    page.should have_content( restaurant.location.city )
    page.should have_content( customer.location.street )
    page.should have_content( customer.location.city )

  end
end
