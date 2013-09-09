require 'spec_helper'

describe OrderItem do
    it { should have_valid( :quantity ).when(1)      }
    it { should_not have_valid( :quantity ).when(0)  }
    it { should_not have_valid( :quantity ).when(-1) }
end
