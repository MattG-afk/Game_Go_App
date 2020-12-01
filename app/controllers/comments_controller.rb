class CommentsController < ApplicationController
    before_action :redirect_to_login

    def new
        if @game = Game.find_by_id(params[:game_id])
            @comment = @game.comment.build
        else
            @comment = Comment.new
        end
      
    end

    def create
        @comment = current_user.comments.build(comment_params)
        if @comment.save
          redirect_to comment_path(@comment)
        else
            render :new
        end

    end

    def show 
        @comment = Comment.find_by_id(params[:id])
    end 

    def index

    end

    def edit

    end

    def update

    end

    def destroy

    end

end
