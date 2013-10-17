require 'spec_helper'

describe 'order state change' do

  before( :each ) do
    @pool = create_pool
  end

  describe 'a customer' do
    before( :each ) do
      sign_in( @pool[:customer] )
    end

    ['requested', 'confirmed', 'claimed'].each do |state|
    it "can cancel a #{state} order" do
      order = create_order( @pool[:customer], @pool[:restaurant], state )
      click_on 'My Orders'
      click_on 'Cancel'
      order.reload
      order.state.should == 'canceled'
      page.should_not have_content( order.restaurant )
    end
    end

    ['picked_up', 'completed', 'canceled'].each do |state|
    it "can not cancel a #{state} order" do
      order = create_order( @pool[:customer], @pool[:restaurant], state )
      click_on 'My Orders'
      page.should_not have_content(/Cancel/)
    end
    end

    ['requested', 'confirmed', 'claimed', 'picked_up', 'canceled', 'completed'].each do |state|
    it "it can not confirm, claim,  pick up, or complete a #{state} order" do
      order = create_order( @pool[:customer], @pool[:restaurant], state )
      click_on 'My Orders'
      page.should_not have_content(/Claim/)
      page.should_not have_content(/Pick Up/)
      page.should_not have_content(/Confirm/)
      page.should_not have_content(/Complete/)
    end
    end
  end

  describe 'an owner' do
    before( :each ) do
      sign_in( @pool[:owner] )
    end

    it 'can confirm a requested order' do
      order = create_order( @pool[:customer], @pool[:restaurant], 'requested')
      click_on 'My Orders'
      click_on 'Confirm'
      order.reload
      order.state.should == 'confirmed'
    end

    ['confirmed', 'claimed', 'picked_up', 'canceled', 'completed'].each do |state|
    it "it can not confirm a #{state} order" do
      order = create_order( @pool[:customer], @pool[:restaurant], state )
      click_on 'My Orders'
      page.should_not have_content(/Confirm/)
    end
    end

    ['requested', 'confirmed', 'claimed', 'picked_up', 'canceled', 'completed'].each do |state|
    it "it can not cancel, claim, pick up, or complete a #{state} order" do
      order = create_order( @pool[:customer], @pool[:restaurant], state )
      click_on 'My Orders'
      page.should_not have_content(/Claim/)
      page.should_not have_content(/Pick Up/)
      page.should_not have_content(/Cancel/)
      page.should_not have_content(/Complete/)
    end
    end
  end

  describe 'a driver' do
    before(:each) do
      sign_in( @pool[:driver] )
    end

    it 'can claim a confirmed order' do
      order = create_order( @pool[:customer], @pool[:restaurant], 'confirmed' )
      click_on 'Possibilities'
      click_on 'Claim'
      order.reload
      order.state.should == 'claimed'
    end
    it 'can pick up a claimed order' do
      order = create_order( @pool[:customer], @pool[:restaurant], 'claimed' )
      order.driver = @pool[:driver]
      order.save

      click_on 'My Orders'
      click_on 'Pick Up'
      order.reload
      order.state.should == 'picked_up'
    end
    it 'can complete a picked up order' do
      order = create_order( @pool[:customer], @pool[:restaurant], 'picked_up' )
      order.driver = @pool[:driver]
      order.save

      click_on 'My Orders'
      click_on 'Complete'
      order.reload
      order.state.should == 'completed'
    end

    ['requested', 'claimed', 'picked_up', 'confirmed', 'canceled'].each do |state|
    it "can not cancel or confirm a #{state} order" do
      create_order( @pool[:customer], @pool[:restaurant], state)
      click_on 'My Orders'
      page.should_not have_content(/Cancel/)
      page.should_not have_content(/Confirm/)
      click_on 'Possibilities'
      page.should_not have_content(/Cancel/)
      page.should_not have_content(/Confirm/)
    end
    end
  end
end
