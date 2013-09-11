require 'spec_helper'

describe Restaurant do
  it_has_string( :name )

  it { should     have_valid( :user ).when( User.new ) }
  it { should_not have_valid( :user ).when( nil ) }

  it { should belong_to( :user  ) }
  it { should have_many( :menus ) }
end
