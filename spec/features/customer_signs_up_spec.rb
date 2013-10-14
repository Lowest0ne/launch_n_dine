require 'spec_helper'

feature 'customer signs up' do

  scenario 'with valid information' do

    ActionMailer::Base.deliveries = []

    total_count  = User.count
    customer_count = User.where( role: 'customer').count

    visit root_path
    click_link 'Customer'

    page.should_not have_selector(:input, id: 'user_restaurants_attributes_0_name')
    page.should_not have_content('Restaurant Street')
    page.should_not have_content('Restaurant City')
    page.should_not have_content('Restaurant State')
    page.should_not have_content('Restaurant Name')

    customer = FactoryGirl.build(:customer)
    location = FactoryGirl.build(:location, findable: customer )

    fill_in 'user_first_name', with: customer.first_name
    fill_in 'user_last_name', with: customer.last_name
    fill_in 'user_locations_attributes_0_street', with: location.street
    fill_in 'user_locations_attributes_0_city', with: location.city
    fill_in 'user_locations_attributes_0_state', with: location.state
    fill_in 'user_email', with: customer.email
    fill_in 'user_password', with: customer.password
    fill_in 'user_password_confirmation', with: customer.password

    click_button 'Sign Up'

    expect( User.count ).to eql( total_count + 1 )
    expect( User.where( role: 'customer' ).count ).to eql( customer_count + 1)
    User.last.location.should_not == nil

    page.should have_content('Sign Out')
    page.should_not have_content('Sign In')
    page.should_not have_content('Sign Up')

    expect( ActionMailer::Base.deliveries.size).to eql(1)
    last_email = ActionMailer::Base.deliveries.last

    expect( last_email ).to have_subject("Launch 'n Dine Welcomes You")
    expect( last_email ).to deliver_to( User.last.email )
    expect( last_email ).to have_body_text("Thanks for being a customer")

  end

  scenario 'with invalid information' do

    total_count = User.count
    ActionMailer::Base.deliveries = []

    visit root_path
    click_link 'Customer'

    click_button 'Sign Up'

    expect( User.count ).to eql( total_count )

    page.should have_content("can't be blank")
    page.should have_content('Sign Up')
    page.should_not have_content('Sign Out')

    expect( ActionMailer::Base.deliveries.size).to eql(0)
    last_email = ActionMailer::Base.deliveries.last
  end
end
