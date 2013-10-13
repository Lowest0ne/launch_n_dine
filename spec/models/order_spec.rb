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
    FactoryGirl.create(:owner)
    FactoryGirl.create(:user)

    order = Order.new
    order.restaurant = Restaurant.first
    order.customer = User.first

    order.should_not be_valid

    order.order_items.new( menu_item: MenuItem.first )
    order.should be_valid

  end

  describe 'states' do
      let (:order) {
        FactoryGirl.create(:owner)
        FactoryGirl.create(:user)

        order = Order.new(customer: User.first,
                          restaurant: Restaurant.first)
        order.order_items.build(menu_item: MenuItem.first)
        order.save
        order
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

      ['ready', 'pick_up', 'complete'].each do |action|
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

      it 'can be readied' do
        order.ready
        order.reload
        order.state.should == 'readied'
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

    describe 'readied' do

      before(:each) do
        order.confirm
        order.ready
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
        order.ready
        order.pick_up
        order.reload
      end

      it 'can be completed' do
        order.complete
        order.reload
        order.state.should == 'completed'
      end

      it 'can be canceled' do
        order.cancel
        order.reload
        order.state.should  == 'canceled'
      end

      ['confirm', 'ready'].each do |action|
        it "does not allow #{action}" do
          order.send(action).should be_false
        end
      end
    end

    describe 'complete' do
      before(:each) do
        order.confirm
        order.ready
        order.pick_up
        order.complete
        order.reload
      end

      ['confirm', 'ready', 'pick_up', 'cancel'].each do |action|
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

      ['confirm', 'ready', 'pick_up', 'complete'].each do |action|
        it "does not allow #{action}" do
          order.send(action).should be_false
        end
      end
    end
  end
end
