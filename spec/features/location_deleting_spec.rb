require 'spec_helper'

describe 'Location Deleteing' do

  it 'can be done with the click of a button' do
    customer = create_signed_in(:customer)
    prev_count = customer.locations.count

    click_on 'My Profile'
    click_on 'View Locations'
    click_on 'Delete'

    page.should have_content( 'Location Deleted' )
    customer.locations.count.should == prev_count - 1

  end



end
