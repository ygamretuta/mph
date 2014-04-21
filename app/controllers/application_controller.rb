class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :html, :json

  # put controller utility methods here for now

  def confirm_transaction_message(transaction)
    return unless transaction.instance_of?(Transaction)

    if transaction.seller_confirmed && transaction.buyer_confirmed?
      'Transaction successful!'
    else
      'Please wait for the other party to confirm transaction.'
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end
end
