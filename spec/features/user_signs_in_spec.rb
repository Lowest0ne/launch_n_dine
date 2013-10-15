require 'spec_helper'

feature 'user signs in' do

  let(:user){ FactoryGirl.create(:customer) }

  scenario 'an existing user with valid information' do

    sign_in(user)

    page.should have_content('Sign Out')
    page.should_not have_content('Sign In')

  end

  scenario 'an existing user with invalid password' do

    user.password = 'wrong_password'
    sign_in(user)

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
