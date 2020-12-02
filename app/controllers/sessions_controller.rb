class SessionsController < ApplicationController
    helper_method :auth

    def new
    end


    def create
        @user = User.find_by(:email => params[:email])
        if @user && @user.authenticate(params[:password])
            login(@user)
            flash[:success] = "Successful login"
            redirect_to "/"
        else
          redirect_to "/login", :notice => "Can't find your login."
        end
    end
    
    def destroy
        reset_session
        redirect_to "/"
    end
    
    def omniauth
        omniauth = request.env['omniauth.auth']['info']
        user = User.find_or_create_by(email: omniauth["email"]) do |u|
            u.username = omniauth["name"]
            u.password = SecureRandom.hex
        end
        session[:current_user_id] = user.id
        redirect_to recipes_path
    end


    private

    def auth
        request.env["omniauth.auth"]['info']
    end

end

