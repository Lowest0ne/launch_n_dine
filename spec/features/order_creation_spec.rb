require 'spec_helper'

feature 'creating orders' do

  it 'can not be done unless signed in' do
    menu = create_pool[:menu]
    visit new_menu_order_path( menu )
    current_path.should == new_user_session_path
  end

  describe 'a signed in user' do

    before :each do
      @prev_count = Order.count
      owner = FactoryGirl.create(:owner)
      @restaurant = FactoryGirl.create(:restaurant, user: owner)
      @menu = FactoryGirl.create(:menu, restaurant: @restaurant)
      @menu_item = FactoryGirl.create(:menu_item, menu: @menu)
      @customer = create_signed_in(:customer)
      click_on @restaurant.name
      click_on 'Menus'
      click_on @menu.name
      click_on 'Create Order'
    end

    it 'creates an order if form filled correctly' do

      select @menu_item.name, from: 'order_order_items_attributes_0_menu_item_id'
      click_on 'Create Order'
      page.should have_content("Order has been created")
      expect(Order.count).to eql( @prev_count + 1 )

    end

    it 'does not create an order if form is empty' do

      click_on 'Create Order'
      page.should_not have_content("Order has been created")
      expect(Order.count).to eql( @prev_count )

    end

    it 'is prompted for address if none is supplied' do
      visit root_path
      click_on 'Restaurants'
      click_on @restaurant.name
      click_on 'Menus'
      click_on @menu.name

      @customer.locations.each{ |l| l.destroy }
      @customer.reload
      click_on 'Create Order'
      current_path.should == new_user_location_path( @customer ) if @customer.locations.empty?
    end
  end
end
