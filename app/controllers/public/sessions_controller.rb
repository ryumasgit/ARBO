# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :member_state, only: [:create]

  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインしました"
    welcome_path
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました"
    root_path
  end

  def guest_sign_in
    member = Member.guest
    sign_in member
    flash[:notice] = "ゲストログインしました"
    redirect_to welcome_path
  end

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
  end

  # # DELETE /resource/sign_out
  def destroy
    #ゲストメンバーのデータを削除する
    if current_member.is_guest?
      current_member.destroy
    end
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # ログイン時、退会ステータスを確認する
  def member_state
    @member = Member.find_by(email: params[:member][:email])
    return if !@member
    if @member.valid_password?(params[:member][:password]) && !@member.is_active
      flash[:alert] = ["入力されたメンバーは退会済みです 新規登録をご利用ください"]
      redirect_to new_member_registration_path
    end
  end
end