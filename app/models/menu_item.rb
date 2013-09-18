class MenuItem < ActiveRecord::Base
  validates_presence_of :name

  validates_presence_of :price
  validates_numericality_of :price, greater_than_or_equal_to: 0

  validates_presence_of :menu_id
  validates_presence_of :menu

  belongs_to :menu
  has_many :order_items
end
