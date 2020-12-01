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
        if @game = Game.find_by_id(params[:game_id])
            @comments = @game.comments
        else
            @comments = Comment.all
        end
    end

    #def destroy
    #    if authorized_to_edit?(@comment)
    #        @comment.destroy

    #end

    private


    def comment_params
        params.require(:comment).permit(:game_id, :content,:stars)

end
