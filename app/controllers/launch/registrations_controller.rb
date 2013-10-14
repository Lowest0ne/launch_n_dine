class Launch::RegistrationsController < Devise::RegistrationsController

  # GET /resource/sign_up
  def new
    build_resource({ role: params[:role] })
    #self.resource.locations.build
    respond_with self.resource
  end

end
