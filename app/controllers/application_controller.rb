class ApplicationController < ActionController::Base
  include Breadcrumbs
  include Pundit::Authorization

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :user_permitted_parameters, if: :devise_controller?
  after_action :verify_pundit_authorization, unless: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def user_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username ])
  end

  def skip_authorizations
    skip_authorization
    skip_policy_scope
  end

  private

  def record_not_found
    flash[:alert] = t("flash.errors.record_not_found")

    redirect_back_or_to(record_not_found_redirect_url)
  end
  def record_not_found_redirect_url
    root_url
  end

  def verify_pundit_authorization
    if action_name == "index"
      verify_policy_scoped
    else
      verify_authorized
    end
  end
end
