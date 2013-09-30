require 'spec_helper'

feature 'user signs in' do

  let(:user){ FactoryGirl.create(:user) }

  scenario 'an existing user with valid information' do

    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Sign In'

    page.should have_content('Sign Out')
    page.should_not have_content('Sign In')

  end

  scenario 'an existing user with invalid password' do

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrong_password'

    click_button 'Sign In'

    page.should_not have_content('Sign Out')
    page.should have_content('Sign In')
    page.should have_content('Invalid email or password')
  end

  scenario 'a non existing user with theoritically valid info' do
    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: 'atotallyvalid@email.com'
    fill_in 'Password', with: 'prettysure'

    click_button 'Sign In'

    page.should_not have_content('Sign Out')
    page.should have_content('Sign In')
    page.should have_content('Invalid email or password')

  end
end
