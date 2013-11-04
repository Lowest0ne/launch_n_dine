require 'spec_helper'

describe RestaurantsController do
  fixtures :users, :restaurants

  let ( :owner )      { users(:owner) }
  let ( :restaurant ) { restaurants(:one) }

  it 'can get new' do
    sign_in owner
    get :new, user_id: owner
    assert_response :ok
    assert_not_nil assigns( :user )
    assert_not_nil assigns( :restaurant )
  end

  it 'can post create with valid info' do
    sign_in owner
    prev_count = Restaurant.count
    post :create, user_id: owner, restaurant: restaurant.attributes
    expect( Restaurant.count ).to eql( prev_count + 1 )
    assert_redirected_to restaurant_path( assigns( :restaurant ) )
  end

  it 'can post create with invalid info' do
    sign_in owner
    prev_count = Restaurant.count
    post :create, user_id: owner, restaurant: { name: '' }
    expect( Restaurant.count ).to eql( prev_count)
    assert_response :ok
    assert_not_nil assigns( :user )
    assert_not_nil assigns( :restaurant )
  end

  it 'can get show' do
    get :show, id: restaurant
    assert_response :ok
    assert_not_nil assigns( :restaurant )
  end

  it 'can get index' do
    get :index, user_id: owner
    assert_response :ok
    assert_not_nil assigns( :user )
    assert_not_nil assigns( :restaurants )
  end

  it 'can get edit' do
    sign_in owner
    get :edit, id: restaurant
    assert_response :ok
    assert_not_nil assigns( :restaurant )
  end

  it 'can post update with valid info' do
    sign_in owner
    post :update, id: restaurant, restaurant: restaurant.attributes
    assert_redirected_to restaurant_path( assigns( :restaurant ) )
  end

  it 'can post update with invalid info' do
    sign_in owner
    post :update, id: restaurant, restaurant: { name: '' }
    assert_not_nil assigns( :restaurant )
    assert_response :ok
  end

  it 'can post destroy' do
    sign_in owner
    prev_count = Restaurant.count
    post :destroy, id: restaurant
    expect( Restaurant.count ).to eql( prev_count - 1 )
  end
end
