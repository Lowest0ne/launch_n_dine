require 'spec_helper'

feature 'owner views restaurants' do

  scenario 'a signed in owner views the restaurants' do

    owner = FactoryGirl.create( :owner )
    sign_in(owner)

    page.should have_content(owner.restaurants.first.name)

  end
end
