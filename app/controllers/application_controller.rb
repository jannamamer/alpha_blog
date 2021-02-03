class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected
    @additional_params = [:username, :first_name, :last_name]

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :first_name, :last_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :first_name, :last_name])
    end
end
