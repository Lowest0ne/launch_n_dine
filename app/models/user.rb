class User < ActiveRecord::Base
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :role

  ROLES = [ 'driver', 'customer', 'owner' ]
  def self.valid_roles
    ROLES
  end



  validates_format_of :role, with: /\Adriver\z|\Acustomer\z|\Aowner\z/

end
