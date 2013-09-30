require 'spec_helper'

feature 'restaurant owner signs up' do

  scenario 'with valid information' do

    prev_count = User.where( role: 'owner').count

    visit root_path
    click_on 'Restaurant Owner?'
    fill_in 'First Name', with: 'Carl'
    fill_in 'Last Name', with: 'Schwope'
    fill_in 'Email', with: 'schwope.carl@gmail.com'
    fill_in 'Password', with: 'my_password'
    fill_in 'Password Confirmation', with: 'my_password'

    fill_in 'Restaurant Name', with: 'Breakfast With Carl'
    fill_in 'Restaurant Address', with: '33 Harrison Ave'
    fill_in 'Restaurant City', with: 'Boston'
    fill_in 'Restaurant State', with: 'Massachusetts'

    click_on 'Sign Up'

    expect( User.where( role: 'owner' ).count ).to eql( prev_count + 1 )

    page.should have_content("Welcome to Launch 'n Dine")
    page.should have_content("Sign Out")
    page.should_not have_content("Sign Up")
    page.should_not have_content("Restaurant Owner?")
    page.should_not have_content("Sign In")

  end


end
