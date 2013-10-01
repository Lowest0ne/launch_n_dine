require 'spec_helper'

feature 'customer signs up' do

  scenario 'with valid information' do

    total_count  = User.count
    customer_count = User.where( role: 'customer').count

    visit root_path
    click_link 'Sign Up'

    page.should_not have_content('Restaurant Street')
    page.should_not have_content('Restaurant City')
    page.should_not have_content('Restaurant State')
    page.should_not have_content('Restaurant Name')

    fill_in 'user_first_name', with: 'Carl'
    fill_in 'user_last_name', with: 'Schwope'
    fill_in 'user_locations_attributes_0_street', with: '40 Beacon St.'
    fill_in 'user_locations_attributes_0_city', with: 'Chelsea'
    fill_in 'user_locations_attributes_0_state', with: 'MA'
    fill_in 'user_email', with: 'schwope.carl@gmail.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'

    click_button 'Sign Up'

    expect( User.count ).to eql( total_count + 1 )
    expect( User.where( role: 'customer' ).count ).to eql( customer_count + 1)

    page.should have_content('Sign Out')
    page.should_not have_content('Sign In')
    page.should_not have_content('Sign Up')

  end

  scenario 'with invalid information' do

    total_count = User.count

    visit root_path
    click_link 'Sign Up'

    click_button 'Sign Up'

    expect( User.count ).to eql( total_count )

    page.should have_content("can't be blank")
    page.should have_content('Sign Up')
    page.should_not have_content('Sign Out')

  end


end
