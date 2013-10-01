require 'spec_helper'

feature 'user signs out' do

  scenario 'a user who is not signed in can not sign out' do
    visit root_path
    page.should_not have_content('Sign Out')
  end

  scenario 'a user who is signed in can sign out' do
    user = FactoryGirl.create(:user)
    sign_in(user)

    click_link 'Sign Out'
  end
end
