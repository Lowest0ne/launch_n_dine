# == Schema Information
#
# Table name: menus
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)      not null
#

class Menu < ActiveRecord::Base
    validates_presence_of :name
end
