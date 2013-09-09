require 'spec_helper'

describe User do
    let ( :user ) { User.new( first_name: "Carl", last_name: "Schwope" ) }

    describe "a valid user" do

        it "should have a first and last name" do
            expect( user.first_name.length > 0 ).to be_true
            expect( user.last_name.length    > 0 ).to be_true
            user.should be_valid
        end
    end

    describe "an invalid user" do

        it "should not have a first name" do
            user.first_name = nil
            user.should_not be_valid
            user.first_name = ''
            user.should_not be_valid
        end

        it "should not have a last name" do
            user.last_name = nil
            user.should_not be_valid
            user.last_name = ''
            user.should_not be_valid
        end
    end

end
