# == Schema Information
#
# Table name: restaurants
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)      not null
#

class Restaurant < ActiveRecord::Base
    validates_presence_of :name
end
