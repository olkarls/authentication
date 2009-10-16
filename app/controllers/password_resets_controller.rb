class PasswordResetsController < PublicController
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  before_filter :require_no_user
  def new
    @password_reset = User.new
    render
  end
  
  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:success] = I18n.translate(:password_reset_instructions).capitalize
      redirect_to root_url
    else
      flash[:error] = I18n.translate(:no_user_found_with_email).capitalize
      render :action => :new
    end
  end
  
  def edit
    render
  end  

  def update  
    @user.password = params[:user][:password]  
    @user.password_confirmation = params[:user][:password_confirmation]  
    if @user.save
      flash[:success] = I18n.translate(:password_updated).capitalize
      redirect_to root_path  
    else  
      render :action => :edit  
    end  
  end  

  private  

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])  
    unless @user  
      flash[:error] = I18n.translate(:no_user_found_with_token).capitalize
      redirect_to root_url  
    end  
  end  
end