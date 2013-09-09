# == Schema Information
#
# Table name: restaurants
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)      not null
#

require 'spec_helper'

describe Restaurant do
    let ( :restaurant ) { Restaurant.new( name: "Breakfast With Carl" ) }

    describe "a valid restaurant" do

        it "should have a name" do
            expect( restaurant.name.length > 0 ).to be_true
            restaurant.should be_valid
        end
    end

    describe "an invalid restaurant" do

        it "should not have a name" do
            restaurant.name = nil
            restaurant.should_not be_valid
            restaurant.name = ''
            restaurant.should_not be_valid
        end
    end
end
