require 'spec_helper'

feature 'restaurant owner signs up' do

  scenario 'with valid information' do

    ActionMailer::Base.deliveries = []

    prev_count = User.where( role: 'owner').count

    visit root_path
    click_on 'Restaurant Owner?'
    fill_in 'user_first_name', with: 'Carl'
    fill_in 'user_last_name', with: 'Schwope'
    fill_in 'user_email', with: 'schwope.carl@gmail.com'
    fill_in 'user_password', with: 'my_password'
    fill_in 'user_password_confirmation', with: 'my_password'

    fill_in 'user_restaurants_attributes_0_name', with: 'Breakfast With Carl'
    fill_in 'user_restaurants_attributes_0_locations_attributes_0_street', with: '33 Harrison Ave'
    fill_in 'user_restaurants_attributes_0_locations_attributes_0_city', with: 'Boston'
    fill_in 'user_restaurants_attributes_0_locations_attributes_0_state', with: 'Massachusetts'

    click_button 'Sign Up'

    expect( User.where( role: 'owner' ).count ).to eql( prev_count + 1 )

    page.should have_content("Welcome to Launch 'n Dine")
    page.should have_content("Sign Out")
    page.should_not have_content("Sign Up")
    page.should_not have_content("Restaurant Owner?")
    page.should_not have_content("Sign In")

    expect( ActionMailer::Base.deliveries.size).to eql(1)
    last_email = ActionMailer::Base.deliveries.last

    expect( last_email ).to have_subject("Launch 'n Dine Welcomes You")
    expect( last_email ).to deliver_to( User.last.email )
    expect( last_email ).to have_body_text("Thanks for owning a Restaurant")
  end


end
