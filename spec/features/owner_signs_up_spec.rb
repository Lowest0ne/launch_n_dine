require 'spec_helper'

feature 'restaurant owner signs up' do

  scenario 'with valid information' do

    ActionMailer::Base.deliveries = []

    prev_count = User.where( role: 'owner').count

    owner = FactoryGirl.build(:owner)
    restaurant = FactoryGirl.build(:restaurant)
    location = FactoryGirl.build(:location)

    visit root_path
    click_on 'Owner'
    fill_in 'user_first_name', with: owner.first_name
    fill_in 'user_last_name', with: owner.last_name
    fill_in 'user_email', with: owner.email
    fill_in 'user_password', with: owner.password
    fill_in 'user_password_confirmation', with: owner.password

    restaurant_str = "user_restaurants_#{owner.id}_"
    fill_in "#{restaurant_str}name", with: restaurant.name
    fill_in "#{restaurant_str}_location__street", with: location.street
    fill_in "#{restaurant_str}_location__city", with: location.city
    fill_in "#{restaurant_str}_location__state", with: location.state

    click_button 'Sign Up'

    expect( User.where( role: 'owner' ).count ).to eql( prev_count + 1 )

    owner = User.last
    owner.restaurants.first.name.should == restaurant.name
    owner.restaurants.first.locations.first.street.should == location.street
    owner.restaurants.first.locations.first.city.should == location.city
    owner.restaurants.first.locations.first.state.should == locations.state


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
