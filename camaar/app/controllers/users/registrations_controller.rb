# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    set_temporary_password_for_resource(resource)

    if resource.save
      handle_user_registration_response(resource)
    else
      handle_registration_failure(resource)
    end
  end

  private

  def send_temp_password_email(resource)
    token = resource.send(:set_reset_password_token) # Generate reset password token
    UserMailer.send_temp_password(resource, token).deliver_now
  end

  def set_temporary_password_for_resource(resource)
    temp_password = Devise.friendly_token.first(8)
    resource.password = temp_password
    resource.password_confirmation = temp_password
  end

  def handle_user_registration_response(resource)
      if resource.active_for_authentication?
        send_temp_password_email(resource) # Send the email with the temporary password
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
  end

  def handle_registration_failure(resource)
    clean_up_passwords resource
    set_minimum_password_length
    respond_with resource
  end
end
