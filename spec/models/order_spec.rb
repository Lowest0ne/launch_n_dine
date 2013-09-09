# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  created_at    :datetime
#  updated_at    :datetime
#  restaurant_id :integer          not null
#

require 'spec_helper'

describe Order do

    less_equal_zero = [ 0, -1, -20 ]

    it { should have_valid( :restaurant_id ).when(1) }
    it { should_not have_valid( :restaurant_id).when( *less_equal_zero ) }
end
