class UserSessionsController < PublicController
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    respond_to do |format|
      if @user_session.save
        flash[:success] = I18n.translate(:successful_login)
        format.html { redirect_back_or_default(root_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:success] = I18n.translate(:successful_logout)
    redirect_to root_url
  end
end
