require 'spec_helper'

describe 'creating a menu' do

  let( :owner ) {FactoryGirl.create(:owner) }
  let( :restaurant ){FactoryGirl.create(:restaurant, user: owner ) }

  it 'can not be done unless signed in' do
    visit new_restaurant_menu_path( restaurant )
    current_path.should == new_user_session_path
  end

  [:customer, :driver].each do |role|
    it "can not be done by #{role}" do
      create_signed_in(role)
      visit new_restaurant_menu_path( restaurant )
      current_path.should == root_path
    end
  end

  it 'can not be done by the wrong owner' do
    create_signed_in(:owner)
    visit new_restaurant_menu_path( restaurant )
    current_path.should == root_path
  end

  describe 'the true owner' do
    before(:each) do
      owner = create_signed_in(:owner)
      @restaurant = FactoryGirl.create(:restaurant, user: owner )
      visit user_path(owner)
      click_on 'My Restaurants'
      click_link @restaurant.name
      click_link 'Menus'
    end

    it 'povides valid info and is told of success' do
      menu = FactoryGirl.build( :menu )

      fill_in 'menu_name', with: menu.name

      prev_count = @restaurant.menus.count
      click_button 'Add Menu'

      page.should have_content('Menu Added')
      page.should have_content( menu.name )

      @restaurant.menus.count.should == prev_count + 1
    end

    it 'does not provide correct info' do

      prev_count = @restaurant.menus.count
      click_button 'Add Menu'

      Menu.count.should == prev_count
      page.should_not have_content('Menu Added')
      page.should have_content("can't be blank")
    end
  end
end
