require 'spec_helper'

describe 'viewing a restaurant' do

  before( :each ) do
    FactoryGirl.create(:owner)
    FactoryGirl.create(:restaurant, user: User.last)
    visit restaurant_path( Restaurant.last )
  end

  let( :restaurant ){ Restaurant.last }

  subject { page }

  it { should have_content( restaurant.name )}
  it { should have_content( restaurant.location.street )}
  it { should have_content( restaurant.location.city   )}
  it { should have_content( restaurant.location.state  )}

  it 'is accessable to a  logged out user' do
    current_path.should == restaurant_path( Restaurant.last )
  end

  describe 'as a customer' do
    before do
      create_signed_in(:customer)
      visit restaurant_path( Restaurant.last )
    end

    it { should_not have_content('View Orders') }
    it { should_not have_content('Edit') }
    it { should_not have_content('Delete') }
  end

  describe 'as a driver' do
    before do
      create_signed_in(:driver)
      visit restaurant_path( Restaurant.last )
    end

    it { should have_content('View Orders') }
    it { should_not have_content('Edit') }
    it { should_not have_content('Delete') }

  end

  describe 'as the owner' do
    before (:each) do
      create_signed_in(:owner)
      FactoryGirl.create(:restaurant, user: User.last )
      visit restaurant_path( Restaurant.last )
    end

    it { should have_content('View Orders') }
    it { should have_content('Edit') }
    it { should have_content('Delete') }
  end

  describe 'as a different owner' do
    before do
      create_signed_in(:owner)
      visit restaurant_path( Restaurant.last )
    end

    it { should_not have_content('View Orders') }
  end
end
