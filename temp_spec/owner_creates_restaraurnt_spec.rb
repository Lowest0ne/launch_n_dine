require 'spec_helper'

describe 'creating a restaurant' do

  describe 'an owner' do

    describe 'who is signed in' do

      it 'who has valid info creates a restaurant' do


      end

      it 'who has invalid is told so' do

        restaurant_count = Restaurant.count
        restaurant = FactoryGirl.build(:restaurant)
        owner = create_signed_in(:owner)
        owner_count = owner.restaurants.count

        click_on 'Add Restaurant'
        click_on 'Create Restaurant'

        page.should_not have_content('Restaurant Created')
        page.should_not have_content( restaurant.name )
        page.should have_content("can't be blank")

        Restaurant.count.should == restaurant_count

      end
    end
  end
end
