require 'spec_helper'

feature 'owner addsa menu item' do

  scenario 'with valid data' do

    owner = create_signed_in(:owner)
    restaurant = owner.restaurants.last
    menu = restaurant.menus.first

    visit restaurant_menus_path( restaurant )
    click_link menu.name

    fill_in 'menu_item_name', with: 'Oatmeal'
    fill_in 'menu_item_description', with: 'A fine breakfast'
    fill_in 'menu_item_price', with: 2.25


    total_count = MenuItem.count
    menus_count = menu.menu_items.count

    click_on 'Create Menu Item'

    page.should have_content("Menu Item Added")

    page.should have_content("Oatmeal")

    expect( MenuItem.count ).to eql(total_count + 1)
    expect( menu.menu_items.count ).to eql( menus_count + 1 )

  end

  scenario 'with invalid data' do

    owner = create_signed_in(:owner)
    restaurant = owner.restaurants.last
    menu = restaurant.menus.first

    visit restaurant_menus_path( restaurant )
    click_link menu.name

    total_count = MenuItem.count

    click_on 'Create Menu Item'

    page.should_not have_content("Menu Item Added")
    page.should have_content("can't be blank")

    expect( MenuItem.count ).to eql(total_count)

  end


end
