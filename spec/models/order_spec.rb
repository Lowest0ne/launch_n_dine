require 'spec_helper'

describe Order do

    less_equal_zero = [ 0, -1, -20 ]

    it { should have_valid( :restaurant_id ).when(1) }
    it { should_not have_valid( :restaurant_id).when( *less_equal_zero ) }
end
