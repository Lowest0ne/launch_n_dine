# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  first_name :string(255)      not null
#  last_name  :string(255)      not null
#

require 'spec_helper'

describe User do

    it { should     have_valid( :first_name ).when( 'Carl' ) }
    it { should_not have_valid( :first_name ).when( '' ) }
    it { should_not have_valid( :first_name ).when( nil ) }

    it { should     have_valid( :last_name ).when( 'Carl' ) }
    it { should_not have_valid( :last_name ).when( '' ) }
    it { should_not have_valid( :last_name ).when( nil ) }

end
