require 'spec_helper'

describe 'order operations' do

  describe 'viewing orders' do

    before( :each ) do
      @owner = FactoryGirl.create(:owner)
      @restaurant = FactoryGirl.create(:restaurant, user: @owner)
      @menu = FactoryGirl.create(:menu, restaurant: @restaurant)
      @menu_item = FactoryGirl.create(:menu_item, menu: @menu)
    end

    it 'user must be signed in' do

      visit restaurant_orders_path( @restaurant )
      current_path.should == new_user_session_path

      visit user_orders_path( @owner )
      current_path.should == new_user_session_path

      visit orders_path
      current_path.should == new_user_session_path
    end

    describe 'restaurant orders path' do

      it 'can not be seen by a customer' do
        customer = create_signed_in(:customer)
        visit restaurant_orders_path( @restaurant )
        current_path.should == root_path
      end

      it 'can be seen by a driver' do
        driver = create_signed_in(:driver)
        visit restaurant_orders_path( @restaurant )
        current_path.should == restaurant_orders_path(@restaurant)
      end

      it 'can be seen by a owner' do
        sign_in( @owner )
        visit restaurant_orders_path( @restaurant )
        current_path.should == restaurant_orders_path(@restaurant)
      end

      it 'is restricted to the actual owner' do
        imposter = create_signed_in( :owner )
        visit restaurant_orders_path( @restaurant )
        current_path.should == root_path
      end
    end
  end
end
