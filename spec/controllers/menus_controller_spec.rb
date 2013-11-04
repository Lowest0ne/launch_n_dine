require 'spec_helper'

describe MenusController do
  fixtures :users, :restaurants, :menus

  let ( :owner )      { users(:owner) }
  let ( :restaurant ) { restaurants(:one) }
  let ( :menu )       { menus(:one) }

  it 'can get new' do
    sign_in owner
    get :new, restaurant_id: restaurant
    assert_response :ok
    assert_not_nil assigns( :restaurant )
    assert_not_nil assigns( :menu )
  end

  it 'can post create with valid info' do
    sign_in owner
    prev_count = Menu.count
    post :create, restaurant_id: restaurant, menu: menu.attributes
    expect( Menu.count ).to eql( prev_count + 1 )
    assert_redirected_to menu_path( assigns( :menu ) )
  end

  it 'can post create with invalid info' do
    sign_in owner
    prev_count = Menu.count
    post :create, restaurant_id: restaurant, menu: {name:''}
    expect( Menu.count ).to eql( prev_count)
    assert_response :ok
    assert_not_nil assigns( :restaurant )
    assert_not_nil assigns( :menu )
  end

  it 'can get show' do
    get :show, id: menu
    assert_response :ok
    assert_not_nil assigns( :menu )
  end

  it 'can get index' do
    get :index, restaurant_id: restaurant
    assert_response :ok
    assert_not_nil assigns( :restaurant )
    assert_not_nil assigns( :menu )
  end

  it 'can get edit' do
    sign_in owner
    get :edit, id: menu
    assert_response :ok
    assert_not_nil assigns( :menu )
  end

  it 'can post update with valid info' do
    sign_in owner
    post :update, id: menu, menu: menu.attributes
    assert_redirected_to menu_path( assigns( :menu ) )
  end

  it 'can post update with invalid info' do
    sign_in owner
    post :update, id: menu, menu: {name:''}
    assert_not_nil assigns( :menu )
    assert_response :ok
  end

  it 'can post destroy' do
    sign_in owner
    prev_count = Menu.count
    post :destroy, id: menu
    expect( Menu.count ).to eql( prev_count - 1 )
  end
end
