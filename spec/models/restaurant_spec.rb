require 'spec_helper'

describe Restaurant do

  it { should validate_presence_of( :name ) }

  it { should     have_valid( :user ).when( User.new ) }
  it { should_not have_valid( :user ).when( nil ) }

  it { should belong_to( :user      ) }
  it { should have_many( :menus     ) }
  it { should have_many( :orders    ) }
  it { should have_many( :locations ) }

end
