# == Schema Information
#
# Table name: menu_items
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)      not null
#  price      :float            not null
#

require 'spec_helper'

describe MenuItem do

    it { should have_valid( :name ).when('Oatmeal') }
    it { should_not have_valid( :name ).when('')    }
    it { should_not have_valid( :name ).when(nil)   }
    it { should have_valid( :price ).when(1)        }
    it { should have_valid( :price ).when(0)        }
    it { should_not have_valid( :price ).when('str')}
    it { should_not have_valid( :price ).when(-1)   }

end
