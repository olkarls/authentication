module Authentication
  def self.included(base)
    base.extend ClassMethods
    puts "Included 'Authentication' into #{base}"
    base.helper_method :current_user
  end

  module ClassMethods
    #helper_method :current_user
  
    #private
  end

    
  
  private
  
  def require_user
    unless current_user
      store_location
      flash[:error] = I18n.translate(:require_user_error_msg)
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:error] = I18n.translate(:require_no_user_error_msg)
      #redirect_to root_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
end