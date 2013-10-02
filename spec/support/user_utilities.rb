require 'spec_helper'

def sign_in user
  visit root_path
  click_link 'Sign In'
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Sign In'
end

def create_signed_in( factory )
  resource = FactoryGirl.create( factory )
  sign_in(resource)
  resource
end
