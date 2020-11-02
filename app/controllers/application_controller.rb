class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected
    @additional_params = [:username, :image, :first_name, :last_name, :gender]

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :image, :first_name, :last_name, :gender])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :image, :first_name, :last_name, :gender])
    end
end
