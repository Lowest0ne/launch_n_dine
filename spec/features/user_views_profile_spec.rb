require 'spec_helper'

describe 'a profile page' do

  it 'can only be seen by the person it belongs to' do

    customer = FactoryGirl.create(:customer)

    visit user_path( customer )
    current_path.should == root_path

    another_customer = create_signed_in( :customer )
    visit user_path( customer )
    current_path.should == root_path

  end

  it 'displays the name of the user' do

    customer = create_signed_in( :customer )
    visit user_path( customer )
    page.should have_content( customer.first_name )
    page.should have_content( customer.last_name )

  end

  describe 'belonging to a restaurant owner' do

    subject {page}

    let( :owner ){
      owner = FactoryGirl.create(:owner)
      FactoryGirl.create(:restaurant, user: owner )
      FactoryGirl.create(:restaurant, user: owner )
      owner
    }
    before ( :each ) do
      sign_in( owner )
      visit user_path( owner )
    end

    it 'contains the name of each restaruant' do
      owner.restaurants.each do |restaurant|
        page.should have_content( restaurant.name )
      end
    end

  end
end
