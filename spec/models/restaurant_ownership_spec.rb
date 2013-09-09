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
    let ( :ownership ) { RestaurantOwnership.new }

    describe "a valid restaurant ownership" do

        it "should have a user and restaurant id" do
            ownership.user_id = 1
            ownership.restaurant_id = 1
            ownership.should be_valid
        end
    end

    describe "an invalid restaurant ownership" do

        it "should not have a user id" do
            ownership.user_id = nil
            ownership.should_not be_valid
        end

        it "should not have a restaurant id" do
            ownership.restaurant_id = nil
            ownership.should_not be_valid
        end
    end
end
