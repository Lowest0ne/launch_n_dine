require 'spec_helper'

describe 'order viewing' do

  before( :each ) do

    @pool = create_pool
    @requested_order = create_order( @pool[:customer], @pool[:restaurant], 'requested' )
    @confirmed_order = create_order( @pool[:customer], @pool[:restaurant], 'confirmed' )
    @claimed_order = create_order( @pool[:customer], @pool[:restaurant], 'claimed' )
    @picked_up_order = create_order( @pool[:customer], @pool[:restaurant], 'picked_up' )
    @completed_order = create_order( @pool[:customer], @pool[:restaurant], 'completed' )
    @canceled_order = create_order( @pool[:customer], @pool[:restaurant], 'canceled' )

  end

  it 'can never happen for a user not signed in' do
    visit root_path
    page.should_not have_content('My Orders')

    visit user_orders_path( @pool[:owner] )
    current_path.should == new_user_session_path

    visit user_orders_path( @pool[:customer] )
    current_path.should == new_user_session_path

    visit user_orders_path( @pool[:owner] )
    current_path.should == new_user_session_path

    visit restaurant_orders_path( @pool[:restaurant] )
    current_path.should == new_user_session_path
  end

  [ :driver, :customer, :owner ].each do | role |
    it "a #{role} can see his/her own orders" do

      user = sign_in( @pool[role] )

      if role == :driver
        Order.all.each do |order|
          order.driver = user
          order.save
          order.reload
        end
      end

      click_on 'My Orders'
      Order.all.each do |order|
        if role == :driver && order.state == 'canceled'
          page.should_not have_content( order.id )

# The location is always the same...
# but the id is a better tell anyway
          #page.should_not have_content( order.restaurant.name )
          #page.should_not have_content( order.restaurant.location.street )
          #page.should_not have_content( order.restaurant.location.city )
          #page.should_not have_content( order.restaurant.location.state )
          #page.should_not have_content( order.customer.location.street )
          #page.should_not have_content( order.customer.location.city )
          #page.should_not have_content( order.customer.location.state )
        else
          page.should have_content( order.id )
          page.should have_content( order.restaurant.name )
          page.should have_content( order.restaurant.location.street )
          page.should have_content( order.restaurant.location.city )
          page.should have_content( order.restaurant.location.state )
          page.should have_content( order.customer.location.street )
          page.should have_content( order.customer.location.city )
          page.should have_content( order.customer.location.state )
        end
      end
    end
  end
  [ :driver, :customer, :owner ].each do | role |
    it "a #{role} can not see other orders" do

      user = create_signed_in( role )
      click_on 'My Orders'

      Order.all.each do |order|
        page.should_not have_content( order.id )
        page.should_not have_content( order.restaurant.name )
        page.should_not have_content( order.restaurant.location.street )
        page.should_not have_content( order.restaurant.location.city )
        page.should_not have_content( order.restaurant.location.state )
        page.should_not have_content( order.customer.location.street )
        page.should_not have_content( order.customer.location.city )
        page.should_not have_content( order.customer.location.state )
        page.should_not have_content( order.state )
      end
    end
  end

  describe 'a driver' do
    it 'can view orders without drivers' do
      early_driver = FactoryGirl.create( :driver )
      orders = Order.where( "state != ? and state != ?", 'requested', 'confirmed' )
      orders.each do |order|
        order.driver = early_driver
        order.save
      end

      late_driver = sign_in( @pool[:driver] )
      click_on 'Possibilities'

      page.should have_content( @requested_order.id )
      page.should have_content( @confirmed_order.id )
      page.should_not have_content( @claimed_order.id )
      page.should_not have_content( @picked_up_order.id )
      page.should_not have_content( @completed_order.id )
    end

    it 'can not view canceled orders as possibiilities' do
      driver = sign_in( @pool[:driver] )
      @canceled_order.driver = driver
      @canceled_order.save
      click_on 'Possibilities'
      page.should_not have_content( @canceled_order.state )
    end

  end

end
