# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  first_name :string(255)      not null
#  last_name  :string(255)      not null
#
# @todo Has many Restaurants through RestaurantOwnership

class User < ActiveRecord::Base
    validates_presence_of :first_name, :last_name

end
