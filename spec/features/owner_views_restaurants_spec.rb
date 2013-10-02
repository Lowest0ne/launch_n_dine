require 'spec_helper'

feature 'owner views restaurants' do

  scenario 'a signed in owner views the restaurants' do

    owner = create_signed_in(:owner)

    page.should have_content(owner.restaurants.first.name)
    page.should have_content(owner.restaurants.last.name)

  end
end
