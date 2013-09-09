class RestaurantOwnership < ActiveRecord::Base
    validates_presence_of :user_id, :restaurant_id
end
