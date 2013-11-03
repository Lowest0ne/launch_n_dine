module RestaurantsHelper

  def user_views(restaurant)
    if current_user
      case current_user.role
        when 'customer'; customer_views
        when 'driver'  ; driver_views
        when 'owner'   ; owner_views( restaurant )
      end
    end
  end

  def customer_views
  end

  def driver_views
    ( link_to 'View Orders', '#' )
  end

  def owner_views( restaurant )
    return if restaurant.user != current_user

    ( link_to 'View Orders', '#') +
    ( link_to 'Edit',   edit_restaurant_path( restaurant ) )+
    ( link_to 'Delete', restaurant_path( restaurant ), method: :delete)
  end

end
