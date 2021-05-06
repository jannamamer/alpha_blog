# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  @additional_params = %i[username first_name last_name]

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:username, :first_name, :last_name,
                                             payment_attributes: [:card_number, :card_cvc, :card_expires_month, :card_expires_year]])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username first_name last_name])
  end
end
