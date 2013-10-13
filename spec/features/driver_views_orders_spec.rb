require 'spec_helper'

feature 'driver views orders' do

  scenario 'it can be done' do

    user = FactoryGirl.create(:user)
    FactoryGirl.create(:owner)

    restaurant = Restaurant.first
    menu = Menu.where( restaurant_id: restaurant.id ).first
    item = menu.menu_items.first

    order = Order.new( customer: User.first, restaurant: restaurant)

    order.order_items.build( menu_item: item )
    order.save

    expect( Order.count ).to_not eql(0)

    driver = create_signed_in(:driver)

    page.should have_content( restaurant.name )
    page.should have_content( restaurant.location.street )
    page.should have_content( restaurant.location.city )
    page.should have_content( user.location.street )
    page.should have_content( user.location.city )

  end
end
