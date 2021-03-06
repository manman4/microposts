class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  
  def show # 追加
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to @user , notice: 'メッセージを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def followings
    @user = User.find(params[:id])
  end
  
  def followers
    @user = User.find(params[:id])
  end
  

  private

  def user_params
    params.require(:user).permit(:name, :email, :area, :hobby, :password,
                                 :password_confirmation)
  end
  
  def correct_user
    @user = User.find(params[:id])
  　redirect_to root_path if current_user != @user
  end
end

