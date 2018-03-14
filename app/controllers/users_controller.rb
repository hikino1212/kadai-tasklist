class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    # 現在は、指定された id の user のタスクを一律、取得してしまっている
    if current_user == User.find(params[:id])
      @tasks = @user.tasks.order('created_at DESC').page(params[:page])
    else
      # 本人じゃない /users/:id を指定した場合は、タスクを強制的に0件にする
      @tasks = []
    end
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
