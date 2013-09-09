# == Schema Information
#
# Table name: order_items
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  quantity   :integer          not null
#

require 'spec_helper'

describe OrderItem do
    it { should have_valid( :quantity ).when(1)      }
    it { should_not have_valid( :quantity ).when(0)  }
    it { should_not have_valid( :quantity ).when(-1) }
end
