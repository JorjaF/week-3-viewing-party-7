class UsersController <ApplicationController 
  def new 
    @user = User.new
  end 

  def show 
    @user = User.find(params[:id])
  end 

  def login_form

  end

  def login
    user = User.find_by(email: params[:email])
    flash[:success] = "Welcome, #{@user.name}!"
    redirect_to user_path(user)
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
