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

    it { should have_valid( :name ).when ( 'Breakfast' )   }
    it { should_not have_valid( :name ).when( '' ) }
    it { should_not have_valid( :name ).when( nil ) }

end
