class UsersController < PublicController
  before_filter :require_no_user
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])    
    respond_to do |format|
      if @user.save
        flash[:success] = 'User was successfully created.'
        format.html { redirect_to root_path() }
      else
        format.html { render :action => "new" }
      end
    end
  end
end