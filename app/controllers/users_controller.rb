class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
  
    def index
      users = User.all
      render json: users, status: :ok
    end
  
    def show
      user = User.find(params[:id])
      render json: user, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: :not_found
    end
 
    def create
      user = User.new(user_params)
  
      if user.save
        render json: user, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      user = User.find(params[:id])
  
      if user.update(user_params)
        render json: user, status: :ok
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: :not_found
    end
  
    def destroy
      user = User.find(params[:id])
      user.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: :not_found
    end
  
    private
  
    def user_params
      params.require(:user).permit(:email, :password, :admin)
    end

end
  