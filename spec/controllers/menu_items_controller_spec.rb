require 'spec_helper'

describe MenuItemsController do

  let ( :owner )      { FactoryGirl.create( :owner ) }
  let ( :restaurant ) { FactoryGirl.create( :restaurant, user: owner) }
  let ( :menu )       { FactoryGirl.create( :menu, restaurant: restaurant) }
  let ( :item_params) { { name: 'name',
                          description: 'description',
                          price: 1.00 } }

  before { sign_in owner }

  it 'can get new' do
    get :new, menu_id: menu
    assert_response :ok
    assert_not_nil assigns( :menu )
	end

  it 'can post create' do
    sign_in owner
    item_count = MenuItem.count
    post :create, menu_id: menu, menu_item: item_params
    expect( MenuItem.count ).to eql( item_count + 1 )

    assert_redirected_to menu_item_path( assigns( :menu_item ) )

	end

  it 'can get show' do
	end

  it 'can get index' do
	end

  it 'can get edit' do
	end

  it 'can post update' do
	end

  it 'can post destroy' do
	end

end
