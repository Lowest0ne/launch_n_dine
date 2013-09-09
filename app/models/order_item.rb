# == Schema Information
#
# Table name: order_items
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  quantity   :integer          not null
#
# @todo belongs to Order
# @todo has one ( and only one ) MenuItem
# @note validates numericality of quantity >0

class OrderItem < ActiveRecord::Base
    validates_numericality_of :quantity, greater_than: 0
end
