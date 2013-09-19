require 'spec_helper'

describe Location do

  it { should validate_presence_of( :street ) }
  it { should validate_presence_of( :city   ) }
  it { should validate_presence_of( :state  ) }

  it { should     have_valid( :findable ).when( User.new ) }
  it { should     have_valid( :findable ).when( Restaurant.new ) }
  it { should_not have_valid( :findable ).when( nil ) }

  it { should belong_to( :findable ) }

end
