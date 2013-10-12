class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [ :first_name, :last_name, :role,
      restaurants_attributes: [ :name, locations_attributes:[ :street, :city, :state] ],
      locations_attributes:[ :street, :city, :state] ]
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.is_a?(User)
        case resource.role
        when 'owner'
          user_path(resource)
        when 'customer'
          restaurants_path
        end
      else
        super
      end
   end
end
