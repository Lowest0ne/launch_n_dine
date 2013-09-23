require 'spec_helper'

describe OrderItem do

  it { should     have_valid( :order ).when( Order.new ) }
  it { should_not have_valid( :order ).when( nil ) }

  it { should     have_valid( :menu_item ).when( MenuItem.new ) }
  it { should_not have_valid( :menu_item ).when( nil ) }

  it { should belong_to( :order ) }
  it { should belong_to( :menu_item ) }

end
