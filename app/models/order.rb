# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  created_at    :datetime
#  updated_at    :datetime
#  restaurant_id :integer          not null
#
# @todo has many OrderItems
# @todo belongs to user
# @todo associate with restaurant
# @note validates numericality of restaurant_id > 0

class Order < ActiveRecord::Base
    validates_numericality_of :restaurant_id, greater_than: 0
end
