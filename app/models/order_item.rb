class OrderItem < ActiveRecord::Base
  validates_presence_of :order
  validates_presence_of :menu_item

  belongs_to :order
  belongs_to :menu_item

end
