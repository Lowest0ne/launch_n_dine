require 'spec_helper'

describe Order do

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
end
