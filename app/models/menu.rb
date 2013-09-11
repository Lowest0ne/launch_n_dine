class Menu < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :restaurant

  belongs_to :restaurant
end
