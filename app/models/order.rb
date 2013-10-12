class Order < ActiveRecord::Base

  validates_presence_of( :customer )
  validates_presence_of( :restaurant )

  validate :at_least_one_order_item

  def at_least_one_order_item
    if self.order_items.blank?
      self.errors.add :base, 'must have at least one order item'
    end
  end


  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id',
              inverse_of: :purchases
  belongs_to :driver, class_name: 'User', foreign_key: 'driver_id',
              inverse_of: :deliveries
  belongs_to :restaurant,
              inverse_of: :orders
  has_many   :order_items, inverse_of: :order
  has_many   :menu_items, through: :order_items,
              inverse_of: :orders

  accepts_nested_attributes_for :order_items
end
