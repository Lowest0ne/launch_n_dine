# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  created_at    :datetime
#  updated_at    :datetime
#  restaurant_id :integer          not null
#

class Order < ActiveRecord::Base
    validates_numericality_of :restaurant_id, greater_than: 0
end
