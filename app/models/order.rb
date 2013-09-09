class Order < ActiveRecord::Base
    validates_numericality_of :restaurant_id, greater_than: 0
end
