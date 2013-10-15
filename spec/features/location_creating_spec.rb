require 'spec_helper'

describe 'Location creating' do

  it 'can not be done unless signed in' do
    customer = FactoryGirl.create(:customer)
    visit new_user_location_path( customer )
    current_path.should == new_user_session_path
  end

  describe 'as a signed in user' do

    before( :each ) do
      @customer = create_signed_in(:customer)
      click_on 'My Profile'
      click_on 'Add Location'
      current_path.should == new_user_location_path( @customer )

      @prev_count = Location.count
      @location = FactoryGirl.build(:location)
    end

    subject { page }

    describe 'with valid information' do

      before( :each ) do
        fill_in 'location_street', with: @location.street
        fill_in 'location_city', with: @location.city
        fill_in 'location_state', with: @location.state
        click_on 'Create Location'
      end

      it { should have_content('Location Added' ) }
      it { should have_content( @location.street ) }
      it { should have_content( @location.city ) }
      it { should have_content( @location.state ) }

      it 'saved my data to the database' do
        Location.count.should == @prev_count + 1
        location = @customer.locations.last
        location.street.should == @location.street
        location.city.should == @location.city
        location.state.should == @location.state
      end

    end

    describe 'with invalid information' do

      before (:each ) do
        click_on 'Create Location'
      end

      it 'does not save into the database' do
        Location.count.should == @prev_count
      end

      it { should_not have_content('Location Added') }
      it { should have_content("Street can't be blank") }
      it { should have_content("City can't be blank") }
      it { should have_content("State can't be blank") }
    end
  end

  it 'can not be done by the wrong user' do
    user = FactoryGirl.create(:customer)
    imposter = create_signed_in(:customer)
    visit new_user_location_path( user )
    current_path.should == root_path
  end
end
