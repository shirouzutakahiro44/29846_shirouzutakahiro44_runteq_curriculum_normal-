class CommentsController < ApplicationController


    def new 
        @comment = Comment.new
    end

    def create
        @comment = current_user.comments.build(comment_params)
        @comment.save
        #binding.pry
    end

    def destroy
        @comment = current_user.comments.find(params[:id])
        @comment.destroy!
        #binding.pry
    end


    private

    def comment_params
      params.require(:comment).permit(:body).merge(board_id: params[:board_id])
    end
    

end
