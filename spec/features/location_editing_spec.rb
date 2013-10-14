require 'spec_helper'

describe 'Location editing' do

  it 'can not be done unless signed in' do
    user = FactoryGirl.create(:customer)
    visit edit_location_path( user.locations.first)
    current_path.should == new_user_session_path
  end

  describe 'a signed in user' do

    before( :each ) do
      @user = create_signed_in(:customer)
    end

    it 'can not edit other users locations' do
      another = FactoryGirl.create(:customer)
      visit edit_location_path( another.locations.first)
      current_path.should == root_path
    end

    subject { page }

    describe 'with valid information' do

      before( :each ) do
        click_on 'My Profile'
        click_on 'View Locations'

        location = @user.locations.first
        path = "#{location.street} #{location.city}, #{location.state}"
        click_on path
        fill_in 'location_street', with: 'diff1'
        fill_in 'location_city', with: 'diff2'
        fill_in 'location_state', with: 'diff3'

        click_on 'Update Location'
      end

      it { should have_content( 'Location Updated' ) }

      it 'should update the database' do
        location = @user.locations.first
        location.street.should == 'diff1'
        location.city.should == 'diff2'
        location.state.should == 'diff3'
      end
    end
  end
end
