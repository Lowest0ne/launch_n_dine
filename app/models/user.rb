class User < ActiveRecord::Base
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :role

  validates_inclusion_of :role, in: [ 'driver', 'customer', 'owner' ]

  has_many :restaurants

end
