class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :admin?

  protected

  def admin?
    raise 'Hacka says wha? (Need to write this code.)'
  end
end