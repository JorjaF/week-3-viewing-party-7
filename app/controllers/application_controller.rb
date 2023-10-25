class ApplicationController < ActionController::Base
  before_action :set_current_user

  private

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def require_session
    unless @current_user
      flash[:error] = 'You must be logged in or registered to access this feature.'
      redirect_to root_path
    end
  end
end
