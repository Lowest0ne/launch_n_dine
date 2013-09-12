require 'spec_helper'

describe Menu do

  it { should validate_presence_of( :name ) }

  it { should     have_valid( :restaurant ).when( Restaurant.new ) }
  it { should_not have_valid( :restaurant ).when( nil ) }

  it { should belong_to( :restaurant ) }
  it { should have_many( :menu_items ) }

end
