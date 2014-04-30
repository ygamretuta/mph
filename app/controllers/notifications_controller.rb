class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.mailbox.notifications
  end

  def destroy
  end
end
