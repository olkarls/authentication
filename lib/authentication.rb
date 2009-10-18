module Authentication
  def self.included(base)
    base.helper_method :current_user
    base.helper_method :has_authority
  end
  
  def has_authority(role)
    if current_user
      needed_role = Role.find_by_name(role.to_s)
      if current_user.role.level >= needed_role.level
        return true
      else
        return false
      end
    else
      return false
    end
  end
  
  def authorize(role)
    unless has_authority(role)
      access_denied
    end
  end
  
  def access_denied
    store_location
    flash[:error] = t(:access_denied)
    redirect_to login_path
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
      redirect_to root_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    to = (session[:return_to] || default)
    session[:return_to] = nil
    redirect_to(to)
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