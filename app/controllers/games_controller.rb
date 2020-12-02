class GamesController < ApplicationController
    before_action :redirect_to_login

    def new
        @game = Game.new 
        @game.build(game_params)
    end

    def create
        @game = current_user.games.build(game_params)
        if @game.save 
            redirect_to game_path(@game)
        else
            render :new
        end
    end

    def show
         find_game
    end 

    def index
        if params[:user_id]
            @games = User.find_by_id[:user_id].games
        elsif params[:name]
            @games = Game.search_by(params[:name])
        else
            @games = Game.all
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
        if authorized_to_edit?(@game)
            find_game
            @game.destroy
            redirect_to user_path(current_user)
        end
    end

    private

    def find_game 
        @game = Game.find_by_id[:game]
        if !@game
            redirect_to games_path
        end
    end

    def game_params
        params.require(:game).permit(:name, :genres, :description,user_id: [],comment_attributes:[:stars,:content])
    end
end
