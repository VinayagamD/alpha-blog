class UsersController < ApplicationController
  before_action :set_users, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show, :new, :create]
  before_action :require_same_user, only:  [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page:params[:page], per_page: 5)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the alpha blog #{@user.username}"
      redirect_to articles_path
    else
      render :new
    end
  end

  def edit

  end
  def destroy
  @user.destroy
    flash[:danger] = "User and all articles created by user have been deleted"
    redirect_to users_path
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your Account was updated successfully"
      redirect_to articles_path
    else
      render :edit
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  private
  def require_admin
    if logged_in? and !current_user.admin?
        flash[:danger] = "Only admin users can perform that action"
      redirect_to root_path
    end
  end

  private
  def set_users
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:username,:email,:password)
  end
  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own account"
      redirect_to root_path
    end
  end
end
