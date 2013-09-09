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

    it { should     have_valid( :name ).when( 'Breakfast With Carl' ) }
    it { should_not have_valid( :name ).when( '' )  }
    it { should_not have_valid( :name ).when( nil ) }

end
