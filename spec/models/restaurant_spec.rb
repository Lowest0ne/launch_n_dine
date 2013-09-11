require 'spec_helper'

describe Restaurant do
  it_has_string( :name )

  it { should belong_to( :user  ) }
  it { should have_many( :menus ) }
end
