require 'spec_helper'

feature 'user views restaurants' do

  scenario 'as a site visitor' do
    FactoryGirl.create(:owner)
    visit root_path
    click_on 'Restaurants'

    Restaurant.all.each do |restaurant|
      page.should have_content( restaurant.name )
    end

  end

end
