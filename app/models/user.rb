class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :role

  validates_inclusion_of :role, in: [ 'driver', 'customer', 'owner' ]

  has_many :restaurants, inverse_of: :user
  has_many :purchases, class_name: 'Order', foreign_key: 'customer_id',
            inverse_of: :customer
  has_many :deliveries, class_name: 'Order', foreign_key: 'driver_id',
            inverse_of: :driver

  has_many :locations, as: :findable, inverse_of: :findable

  accepts_nested_attributes_for :restaurants
  accepts_nested_attributes_for :locations

  after_create :send_registration_email

  def location
    locations.first
  end

  private
  def send_registration_email
    case self.role
      when 'customer'
        CustomerMailer.registration(self).deliver
      when 'owner'
        OwnerMailer.registration(self).deliver
      when 'driver'
        DriverMailer.registration(self).deliver
    end

  end

end
