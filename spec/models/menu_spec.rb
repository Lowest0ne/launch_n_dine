require 'spec_helper'

describe Menu do

  it_has_string( :name )

  it { should     have_valid( :restaurant ).when( Restaurant.new ) }
  it { should_not have_valid( :restaurant ).when( nil ) }

  it { should belong_to( :restaurant ) }

end
