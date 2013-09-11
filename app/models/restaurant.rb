class Restaurant < ActiveRecord::Base
  validates_presence_of :name

  belongs_to :user, inverse_of: :restaurants
end
