module LocationsHelper

  def location_options( location )

    return unless current_user
    return unless current_user.location == location

    ( link_to 'Edit', edit_location_path( location )) +
    ( link_to 'Delete', location_path( location ), method: :delete )
  end
end
