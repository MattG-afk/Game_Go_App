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
          redirect_to game_comments_path(@comment)
        else
            render :new
        end

    end

    def show 
        find_comment
    end 

    def index
        if @game = Game.find_by_id(params[:game_id])
            @comments = @game.comments
        else
            @comments = Comment.all
        end
    end

    def edit
        find_comment
    end

    def destroy
        if authorized_to_edit?(@comment)
            find_comment
            @comment.destroy
            redirect_to user_path(current_user)
        end
    end

    private

    def find_comment 
        @comment = Comment.find_by_id[params[:game_id]]
        if !@comment
            redirect_to game_comments_path
        end
    end



    def comment_params
        params.require(:comment).permit(:game_id, :content,:stars)
    end

end
