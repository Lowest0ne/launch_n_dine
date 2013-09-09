require 'spec_helper'

describe MenuItem do
    let ( :item ) { MenuItem.new( name: "Oatmeal", price: 3.25 ) }

    describe "a valid menu item" do

        it "should have a name and price" do
            expect( item.name.length > 0).to be_true
            expect( item.price != nil).to be_true
        end

        it "should have a positive price" do
            expect( item.price >= 0 ).to be_true
            item.should be_valid
        end
    end

    describe "an invalid menu item" do

        it "should not have a name" do
            item.name = nil
            item.should_not be_valid
            item.name = ''
            item.should_not be_valid
        end

        it "should not have a price" do
            item.price = nil
            item.should_not be_valid
        end

        it "should have a negative price" do
            item.price = -1
            item.should_not be_valid
        end
    end
end
