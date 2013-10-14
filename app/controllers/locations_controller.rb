class LocationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_create, only: [:new, :create]
  before_filter :authorize_update, only: [:edit, :update]

  def authorize_create
    redirect_to root_path unless current_user.id == params[:user_id].to_i
  end

  def authorize_update
    location = Location.find( params[:id] )
    redirect_to root_path unless location.findable.id == current_user.id
  end

  def new
    @user = User.find( params[:user_id] )
    @location = Location.new
  end

  def create
    @user = User.find( params[:user_id] )
    @location = @user.locations.build( location_params )

    if @location.save
      redirect_to locations_path,  notice: 'Location Added'
    else
      render :new
    end
  end

  def show
    @location = Location.find( params[:id] )
  end

  def index
    @locations = current_user.locations
  end

  def edit
    @user = current_user
    @location = Location.find( params[:id] )
  end

  def update
    @location = Location.find( params[:id] )
    if @location.update( location_params )
      redirect_to locations_path, notice: 'Location Updated'
    else
      render :edit
    end
  end

  def destroy
    Location.find( params[:id] ).destroy
    redirect_to locations_path, notice: 'Location Deleted'
  end


  private
  def location_params
    params.require(:location).permit(:street, :city, :state)
  end

end
