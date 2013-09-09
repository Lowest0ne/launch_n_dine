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
# @todo Belongs to Menu
# @note validates presence of name
# @note validates numericality of price, with value >= 0

class MenuItem < ActiveRecord::Base
    validates_presence_of     :name
    validates_numericality_of :price, greater_than_or_equal_to: 0

end
