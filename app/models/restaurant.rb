class Restaurant < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :user

  belongs_to :user, inverse_of: :restaurants

  has_many :menus
end
