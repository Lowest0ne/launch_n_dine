class Launch::RegistrationsController < Devise::RegistrationsController

  # GET /resource/sign_up
  def new
    build_resource({ role: params[:role] })

    case params[:role]
      when 'owner' then
        self.resource.restaurants.build
        self.resource.restaurants.last.locations.build
      when 'customer' then
        self.resource.locations.build
    end

    respond_with self.resource
  end

end
