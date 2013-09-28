require 'spec_helper'

describe MenuItem do

  it { should validate_presence_of( :name ) }

  it { should validate_presence_of( :price ) }
  it { should validate_numericality_of( :price )}
  it { should_not have_valid( :price ).when(-1.0) }

  it { should     have_valid(:menu).when(Menu.new) }
  it { should_not have_valid(:menu).when(nil) }

  it { should belong_to( :menu ) }
  it { should have_many( :order_items ) }

end
