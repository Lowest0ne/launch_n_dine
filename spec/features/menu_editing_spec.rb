require 'spec_helper'

describe 'editing a menu' do

  before( :each ) do
    @owner = FactoryGirl.create(:owner)
    @restaurant = FactoryGirl.create(:restaurant, user: @owner)
    @menu = FactoryGirl.create(:menu, restaurant: @restaurant )
    @menu_name = @menu.name
  end

  it 'can not be done unless signed in' do
    visit edit_menu_path(@menu)
    current_path.should == new_user_session_path
  end

  [:driver, :customer, :owner].each do |role|
    it "can not be done by random #{role}" do
      create_signed_in( role )
      visit menu_path( @menu )
      page.should_not have_content('Edit')
      visit edit_menu_path( @menu )
      current_path.should == root_path
    end
  end

  describe 'as the owner of the menu' do
    before(:each) do
      sign_in(@owner)
      click_on 'My Restaurants'
      click_on @restaurant.name
      click_on 'Menus'
      click_on 'Edit'
    end

    describe 'with valid information' do

      before(:each) do
        fill_in 'menu_name', with: 'diff1'
        click_on 'Update Menu'
      end

      subject { page }
      it{ should have_content('Menu Updated') }
      it{ should have_content('diff1') }
      it{ should_not have_content(@menu_name) }

      it 'should update the menu' do
        @menu.reload
        @menu.name.should == 'diff1'
      end
    end

    describe 'with invalid information' do
      before( :each ) do
        fill_in 'menu_name', with: ''
        click_on 'Update Menu'
      end

      subject { page }
      it { should have_content("can't be blank") }

      it "does not change the name of the menu" do
        @menu.reload
        @menu.name.should_not == ''
      end
    end
  end
end
