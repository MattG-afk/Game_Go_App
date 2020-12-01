class UsersController < ApplicationController
    skip_before_action :redirect_to_login, only: [:new, :create]
    def new

    end

    def create
        @user = User.new(user_params)
        if @user.valid?
            @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def show
        redirect_to_login
        @user = User.find_by(id: params[:id]) 
        redirect_to '/' if !@user
    end

    private 

    def user_params
        params.require(:user).permit(:username, :email, :password, :first_name, :last_name)
    end

end
