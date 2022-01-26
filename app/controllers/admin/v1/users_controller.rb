module Admin::V1
  class UsersController < ApplicationController

    def index
      @users = User.all
    end
  
    def create
      @user = User.new
      @user.attributes = user_params
      save_user!
    end
  
    def show
  
    end
  
    def update
  
    end
  
    def destroy
  
    end
  
    private
  
    def user_params
      return {} unless params.has_key?(:user)
      params.require(:user).permit( %i(
        name email password password_confirmation
      ))
    end
  
    def load_user
  
    end
  
    def save_user!
      @user.save!
      render :show
    rescue
      render_error(fields: @user.errors.messages)
    end
  end
end