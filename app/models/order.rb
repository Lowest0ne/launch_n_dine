class Order < ActiveRecord::Base

  validates_presence_of( :customer )
  validates_presence_of( :restaurant )

  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id'
  belongs_to :driver, class_name: 'User', foreign_key: 'driver_id'
  belongs_to :restaurant

end
