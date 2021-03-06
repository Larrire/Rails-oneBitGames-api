module Admin::V1
  class UsersController < ApiController

    before_action :load_user, only: [:update, :destroy]

    def index
      @users = User.all
    end
  
    def create
      @user = User.new
      @user.attributes = user_params
      save_user!
    end
  
    def show
      @user = User.find(params[:id])
    rescue
      render_error(message: 'User not found')
    end
  
    def update
      @user.attributes = user_params
      save_user!
    end
  
    def destroy
      @user.destroy!
    end
  
    private
  
    def user_params
      return {} unless params.has_key?(:user)
      params.require(:user).permit( %i(
        name email password password_confirmation
      ))
    end
  
    def load_user
      @user = User.find(params[:id])
    end
  
    def save_user!
      @user.save!
      render :show
    rescue
      render_error(fields: @user.errors.messages)
    end
  end
end