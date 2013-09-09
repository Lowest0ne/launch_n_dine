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

class MenuItem < ActiveRecord::Base
    validates_presence_of     :name
    validates_numericality_of :price, greater_than_or_equal_to: 0
end
