# == Schema Information
#
# Table name: menus
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)      not null
#

require 'spec_helper'

describe Menu do
    let ( :menu ) { Menu.new( name: "Breakfast" ) }

    describe "a valid menu" do

        it "should have a name" do
            expect( menu.name.length > 0 ).to be_true
            menu.should be_valid
        end

    end

    describe "an invalid menu" do

        it "should not have a name" do
            menu.name = nil
            menu.should_not be_valid
            menu.name = ''
            menu.should_not be_valid
        end
    end
end
