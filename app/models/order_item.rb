class OrderItem < ActiveRecord::Base
    validates_numericality_of :quantity, greater_than: 0
end
