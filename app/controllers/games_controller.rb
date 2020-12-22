class GamesController < ApplicationController
    before_action :redirect_to_login

    def new
        @game = Game.new 
        @game.comments.build
    end

    def create
        @game = Game.new(game_params)
        #byebug
        if @game.save 
            redirect_to game_path(@game)
        else
            render :new
        end
    end

    def show
        @game = Game.find(params[:id])
    end 

    def index
        if params[:user_id]
            @game = User.find(params[:user_id]).game
        elsif params[:name]
            byebug
            @game = Game.search_by_name(params[:name])
        else
            @game = Game.all
        end
    end

    def edit
        find_game
    end

    def update
        find_game
        if @game.update(game_params)
            redirect_to game_path(@game)
        else
            render :edit
        end
    end

    def destroy
        @game = Game.find_by(id: params[:id])

        #byebug
        #if #authorized_to_edit?(@game)
        #find_game
        @game.destroy
        redirect_to games_path(@game)
        #end
    end

    private

    def find_game 
        @game = Game.find_by(id: params[:id])
    end

    def game_params
        params.require(:game).permit(:name, :genres, :description,comments_attributes:[:stars,:content,:user_id])
    end
end
