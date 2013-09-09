require 'spec_helper'

describe Order do
    let ( :order ) { Order.new( restaurant_id: 1) }

    describe "a valid order" do
        it "should have a restaurant id greater than zero" do
            expect( order.restaurant_id > 0).to be_true
            order.should be_valid
        end

        it "should have a numerical restaurant id" do
            expect( order.restaurant_id.to_i.to_s ).to eql( order.restaurant_id.to_s )
            order.should be_valid
        end
    end
    describe "an invalid order" do
        it "should not have a restaurant id greater than zero" do
            order.restaurant_id = nil
            order.should_not be_valid
            order.restaurant_id = -1
            order.should_not be_valid
        end

        it "should not have a numerical restaurant id" do
            order.restaurant_id = "Breakfast with Carl"
            order.should_not be_valid
        end
    end
end
