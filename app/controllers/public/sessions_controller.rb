# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :member_state, only: [:create]

  def after_sign_in_path_for(resource)
    reviews_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  
  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to reviews_path(member)
  end

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  protected

  def member_state
    @member = Member.find_by(email: params[:email])
    return if !@member
    if @member.valid_password?(params[:email][:password]) && (@member.is_active == false)
      redirect_to new_member_registration_path, notice: "退会済みのメンバーです。新規登録をしてご利用ください。"
    end
  end
end
