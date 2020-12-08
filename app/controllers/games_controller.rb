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
        @games = Game.find(params[:id])
    end 

    def index
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
        @games = Game.find(params[:id])
        if !@game
            redirect_to games_path
        end
    end

    def game_params
        params.require(:game).permit(:name, :genres, :description,comment_attributes:[:stars,:content,:user_id])
    end

