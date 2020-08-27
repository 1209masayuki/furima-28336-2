class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # def create
  #   @user = User.new(configure_permitted_parameters)
  #   if @user.valid?
  #    @user.save
  #   return redirect_to root_path
  #   else
  #    render "registrations/new"
  #   end
  #  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_date])
  end
end
