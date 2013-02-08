# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue
      session[:user_id] = nil
      redirect_to root_path
    end
  end

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def current_resource
    nil
  end

  def authorize
    if !current_permission.allow?(controller, params[:action], current_resource)
      redirect_to root_url, notice: "閲覧権限がありません．ログインしてください．"
    end
  end

  helper_method :current_user, :signed_in?
end
