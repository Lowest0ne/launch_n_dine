class Order < ActiveRecord::Base

  validates_presence_of :customer
  validates_presence_of :restaurant
  validates_presence_of :state

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

  state_machine :state, initial: :requested do
    state :requested
    state :confirmed
    state :claimed
    state :picked_up
    state :completed
    state :canceled

    event :confirm do
      transition requested: :confirmed
    end

    event :claim do
      transition confirmed: :claimed
    end

    event :pick_up do
      transition claimed: :picked_up
    end

    event :complete do
      transition picked_up: :completed
    end

    event :cancel do
      transition requested: :canceled
      transition confirmed: :canceled
      transition claimed:   :canceled
    end

  end

end
