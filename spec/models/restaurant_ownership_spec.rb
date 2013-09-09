# == Schema Information
#
# Table name: restaurant_ownerships
#
#  id            :integer          not null, primary key
#  created_at    :datetime
#  updated_at    :datetime
#  user_id       :integer          not null
#  restaurant_id :integer          not null
#

require 'spec_helper'

describe RestaurantOwnership do

    it { should have_valid( :user_id ).when(1)     }
    it { should_not have_valid( :user_id).when(0)  }
    it { should_not have_valid( :user_id).when(-1) }

    it { should have_valid( :restaurant_id ).when(1)     }
    it { should_not have_valid( :restaurant_id).when(0)  }
    it { should_not have_valid( :restaurant_id).when(-1) }
end
