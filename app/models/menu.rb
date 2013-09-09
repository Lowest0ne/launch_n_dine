# == Schema Information
#
# Table name: menus
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)      not null
#
# @todo Has many MenuItems
# @todo Belongs to a Restaurant
# @note validates presence of name

class Menu < ActiveRecord::Base
    validates_presence_of :name
end
