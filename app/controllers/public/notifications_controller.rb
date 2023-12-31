class Public::NotificationsController < ApplicationController
  before_action :authenticate_member!

  def index
    notifications = current_member.passive_notifications.page(params[:page]).per(20)
    notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
    @notifications = notifications.joins(:visitor).where(members: { is_active: true })
  end
end