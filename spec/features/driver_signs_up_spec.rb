require 'spec_helper'

feature 'driver signs up' do

  scenario 'with valid information' do

    total_count = User.count
    driver_count = User.where( role: 'driver' ).count

    visit root_path
    click_link 'Driver?'

    fill_in "user_first_name", with: 'Carl'
    fill_in 'user_last_name', with: 'Schwope'
    fill_in 'user_email', with: 'schwope.carl@gmail.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'

    click_button 'Sign Up'

    expect( User.count ).to eql( total_count + 1)
    expect( User.where( role: 'driver').count).to eql( driver_count + 1 )

    page.should have_content( 'Sign Out' )
    page.should_not have_content( 'Sign In' )
    page.should_not have_content( 'Sign Up' )
  end

  scenario 'with invalid information' do

    total_count = User.count
    visit root_path
    click_link 'Driver?'

    click_button 'Sign Up'

    expect( User.count ).to eql( total_count )

    page.should have_content("can't be blank")
    page.should have_content('Sign In')
    page.should have_content('Sign Up')

    page.should_not have_content('Sign out')

  end

end
