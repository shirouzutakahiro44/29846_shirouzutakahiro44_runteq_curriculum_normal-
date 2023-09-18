class CommentsController < ApplicationController


    def new 
        @comment = Comment.new
    end

    def create
        @board = Board.find(params[:board_id])
        @comment = current_user.comments.build(comment_params)
        @comment.board_id = @board.id
          if @comment.save
            flash[:success] = t('defaults.message.created', item: Comment.model_name.human)
            redirect_to @board
          else
              flash.now[:danger] = t('defaults.message.not_created', item: Comment.model_name.human) 
              render 'boards/show'
          end
          #binding.pry
    end

    def destroy
        @comment.destroy
        respond_to do |format|
          format.html { redirect_to board_url, notice: 'Comment was successfully destroyed.' }
          format.json { head :no_content }
        end
      end


    private

    def comment_params
        params.require(:comment).permit(:body, :board_id, :user_id)
    end
    

end
