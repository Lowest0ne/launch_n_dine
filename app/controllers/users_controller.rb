class UsersController < ApplicationController

  def show
    redirect_to root_path unless current_user && current_user.id == params[:id].to_i
  end


end
