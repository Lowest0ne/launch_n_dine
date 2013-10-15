module OrdersHelper

  def order_options( order )
    return unless current_user

    customer_cancels = ['requested', 'confirmed', 'claimed']
    owner_confirms = ['requested']

    case current_user.role
    when 'customer'
      if customer_cancels.include?( order.state )
        link_to( 'Cancel', order_path( order, command: 'cancel' ), method: :patch )
      end
    when 'owner'
      if owner_confirms.include?( order.state )
        link_to( 'Confirm', order_path( order, command: 'confirm' ), method: :patch )
      end
    when 'driver'
      case order.state
      when 'confirmed'
        link_to( 'Claim', order_path( order, command: 'claim' ), method: :patch )
      when 'claimed'
        link_to( 'Pick Up', order_path( order, command: 'pick_up'), method: :patch )
      when 'picked_up'
        link_to( 'Complete', order_path( order, command: 'complete'), method: :patch )
      end
    end


  end
end
