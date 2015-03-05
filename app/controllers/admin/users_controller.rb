class Admin::UsersController < ApplicationController

  before_filter :restrict_access
  before_filter :restrict_admin_access

  def index
    @users = User.all.page(params[:page]).per(10)
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(admin_user_params)

    if @user.save
      redirect_to admin_users_path, notice: "User Created!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(admin_user_params)
    if @user.save
      redirect_to admin_users_path, notice: "Successfull Edit"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, notice: "User deleted"
    else
      render :show
    end
  end

  protected
  def admin_user_params
    params.require(:user).permit(:email, :firstname, :lastname, :admin, :password, :password_confirmation)
  end

end 
