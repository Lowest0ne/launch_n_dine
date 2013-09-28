class Location < ActiveRecord::Base

  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :findable

  belongs_to :findable, polymorphic: true
end
