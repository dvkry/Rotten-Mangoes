class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def restrict_access        
    redirect_to new_session_path, alert: "You must log in." if !current_user
  end

  def restrict_admin_access
    redirect_to movies_path, alert: "You are not authorized" unless current_user.admin?
  end

  def admin?
    current_user.admin if current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def load_movie
    @movie = Movie.find(params[:id])
  end

  helper_method :current_user
end
