require 'spec_helper'

describe MenuItemsController do
  fixtures :users, :restaurants, :menus, :menu_items

  let ( :owner )      { users(:owner) }
  let ( :menu )       { menus(:one) }
  let ( :menu_item )  { menu_items(:one ) }

  it 'can get new' do
    sign_in owner
    get :new, menu_id: menu
    assert_response :ok
    assert_not_nil assigns( :menu )
  end

  it 'can post create with valid info' do
    sign_in owner
    item_count = MenuItem.count
    post :create, menu_id: menu, menu_item: menu_item.attributes
    expect( MenuItem.count ).to eql( item_count + 1 )
    assert_redirected_to menu_item_path( assigns( :menu_item ) )
  end

  it 'can post create with invalid info' do
    sign_in owner
    item_count = MenuItem.count
    post :create, menu_id: menu, menu_item: {name:'', description:'', price:''}
    expect( MenuItem.count ).to eql( item_count)
    assert_response :ok
    assert_not_nil assigns( :menu )
    assert_not_nil assigns( :menu_item )
  end

  it 'can get show' do
    get :show, id: menu_item
    assert_response :ok
    assert_not_nil assigns( :menu_item )
  end

  it 'can get index' do
    get :index, menu_id: menu
    assert_response :ok
    assert_not_nil assigns( :menu_items )
    assert_not_nil assigns( :menu )
  end

  it 'can get edit' do
    sign_in owner
    get :edit, id: menu_item
    assert_response :ok
    assert_not_nil assigns( :menu_item )
  end

  it 'can post update with valid info' do
    sign_in owner
    post :update, id: menu, menu_item: menu.attributes
    assert_redirected_to menu_item_path( assigns( :menu_item ) )
  end

  it 'can post update with invalid info' do
    sign_in owner
    post :update, id: menu, menu_item: {name:'', description:'', price:''}
    assert_not_nil assigns( :menu_item )
    assert_response :ok
  end

  it 'can post destroy' do
    sign_in owner
    prev_count = MenuItem.count
    post :destroy, id: menu_item
    expect( MenuItem.count ).to eql( prev_count - 1 )
  end
end
