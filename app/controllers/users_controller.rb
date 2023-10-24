class UsersController <ApplicationController 
  def new 
    @user = User.new
  end 

  def show 
    user = User.find_by(id: params[:id])
    if user == @current_user
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end 

  def login_user
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:error] = 'Invalid Credentials'
      redirect_to login_path
    end
  end

  def login_form
    @user = User.new
    render 'login_form'
  end

  def create
    user_params[:email] = user_params[:email].downcase
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "Welcome, #{@user.name}!"
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 
