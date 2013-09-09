class MenuItem < ActiveRecord::Base
    validates_presence_of     :name
    validates_numericality_of :price, greater_than_or_equal_to: 0
end
