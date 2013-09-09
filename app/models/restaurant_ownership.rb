# == Schema Information
#
# Table name: restaurant_ownerships
#
#  id            :integer          not null, primary key
#  created_at    :datetime
#  updated_at    :datetime
#  user_id       :integer          not null
#  restaurant_id :integer          not null
#
# @todo Belongs to User
# @todo Belongs to Restaurant
# @note validates presence of user_id, restaurant_id


class RestaurantOwnership < ActiveRecord::Base
    validates_presence_of :user_id, :restaurant_id
end