class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :role

  validates_inclusion_of :role, in: [ 'driver', 'customer', 'owner' ]

  has_many :restaurants
  has_many :purchases, class_name: 'Order', foreign_key: 'customer_id'
  has_many :deliveries, class_name: 'Order', foreign_key: 'driver_id'

  has_many :locations, as: :findable

end
