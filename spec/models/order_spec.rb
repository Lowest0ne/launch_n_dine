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
end
