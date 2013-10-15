require 'spec_helper'

describe 'Location viewing' do

  it 'can not be done unless signed in' do
    user = FactoryGirl.create(:customer)
    visit locations_path
    current_path.should == new_user_session_path
  end

  describe 'a signed in user' do

    it 'can see all his/her locations' do
      user = create_signed_in(:customer)
      click_on 'My Profile'
      click_on 'View Locations'
      user.locations.each do |location|
        page.should have_content( location.street )
        page.should have_content( location.city )
        page.should have_content( location.state )
      end

    end

    it 'can not see anyone elses locations' do
      user = FactoryGirl.create(:customer)
      imposter = create_signed_in(:customer)
      click_on 'My Profile'
      click_on 'View Locations'
      user.locations.each do |location|
        page.should_not have_content( location.street )
        page.should_not have_content( location.city )
        page.should_not have_content( location.state )
      end
    end

  end


end
