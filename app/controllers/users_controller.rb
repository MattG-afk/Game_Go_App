class UsersController < ApplicationController
    skip_before_action :redirect_to_login, only: [:new, :create]
    
    def new 
        @user = User.new 
        if session[:current_user_id]
            redirect_to "/", :notice => "Already logged in"
        end
    end

    def create
        @user = User.new(user_params)
        if @user.valid?
            @user.save
            session[:user_id] = @user.id
            redirect_to "/login"
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
        #byebug
        params.require(:user).permit(:username, :email, :password, :first_name, :last_name)
    end

end
