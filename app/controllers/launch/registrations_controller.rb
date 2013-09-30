class Launch::RegistrationsController < Devise::RegistrationsController

  # GET /resource/sign_up
  def new
    build_resource({ role: params[:role] })

    self.resource.locations.build
    self.resource.restaurants.build if params[:role] == 'owner'
    self.resource.restaurants.last.locations.build if params[:role] == 'owner'


    respond_with self.resource
  end

  protected
  def after_sign_in_path_for( resource_or_scope )
    user_path( current_user )
  end

end
