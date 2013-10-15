require 'spec_helper'

describe Order do
  it { should validate_presence_of( :state ) }

  it { should     have_valid(:customer).when( User.new ) }
  it { should_not have_valid(:customer).when( nil ) }

  it { should     have_valid(:restaurant).when( Restaurant.new ) }
  it { should_not have_valid(:restaurant).when( nil ) }

  it { should belong_to(:customer) }
  it { should belong_to(:driver) }
  it { should belong_to(:restaurant) }

  it { should have_many(:order_items) }
  it { should have_many(:menu_items).through(:order_items) }

  it 'must have at least one order_item' do
    pool = create_pool
    order = Order.new( customer: pool[:customer], restaurant: pool[:restaurant])

    order.should_not be_valid

    order.order_items.new( menu_item: MenuItem.first )
    order.should be_valid

  end

  describe 'states' do
      let (:order) {
        pool = create_pool
        create_order( pool[:customer], pool[:restaurant] )
      }

    describe 'initial' do

      it 'defaults to requested' do
        order.state.should == 'requested'
      end

      it 'can be confirmed' do
        order.confirm
        order.reload
        order.state.should == 'confirmed'
      end

      it 'can be canceled' do
        order.cancel
        order.reload
        order.state.should == 'canceled'
      end

      ['claim', 'pick_up', 'complete'].each do |action|
        it "should not allow #{action}" do
          order.send(action).should be_false
        end
      end
    end

    describe 'confirmed' do
      before( :each ) do
        order.confirm
        order.reload
      end


      it 'can be claimed' do
        order.claim
        order.reload
        order.state.should == 'claimed'
      end

      it 'can be canceled' do
        order.cancel
        order.reload
        order.state.should == 'canceled'
      end

      ['pick_up', 'complete'].each do |action|
        it "does not allow #{action}" do
          order.send(action).should be_false
        end
      end

    end

    describe 'claim' do

      before(:each) do
        order.confirm
        order.claim
        order.reload
      end

      it 'can be picked up' do
        order.pick_up
        order.reload
        order.state.should == 'picked_up'
      end

      it 'can be canceled' do
        order.cancel
        order.reload
        order.state.should == 'canceled'
      end

      ['confirm', 'complete'].each do |action|
        it "should not allow #{action}" do
          order.send(action).should be_false
        end
      end
    end

    describe 'picked_up' do
      before(:each) do
        order.confirm
        order.claim
        order.pick_up
        order.reload
      end

      it 'can be completed' do
        order.complete
        order.reload
        order.state.should == 'completed'
      end

      ['confirm', 'claim', 'cancel'].each do |action|
        it "does not allow #{action}" do
          order.send(action).should be_false
        end
      end
    end

    describe 'complete' do
      before(:each) do
        order.confirm
        order.claim
        order.pick_up
        order.complete
        order.reload
      end

      ['confirm', 'claim', 'pick_up', 'cancel'].each do |action|
        it "does not allow #{action}" do
          order.send(action).should be_false
        end
      end
    end

    describe 'canceled' do
      before(:each) do
        order.cancel
        order.reload
      end

      ['confirm', 'claim', 'pick_up', 'complete'].each do |action|
        it "does not allow #{action}" do
          order.send(action).should be_false
        end
      end
    end
  end
end
