class BoardsController < ApplicationController

  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end

  def show
    @board = Board.find(params[:id])
    @comments = @board.comments.includes(:user).order(created_at: :desc)
    @comment = current_user.comments.new
    @comment.board_id == @board_id
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.new(board_params)
    respond_to do |format|
    if @board.save
      flash[:success] = t('defaults.message.created', item: Board.model_name.human)
        format.html { redirect_to boards_path, notice: 'Board was successfully created.' }
        format.json { render :show, status: :created, location: @board }
    else
        flash.now[:danger] = t('defaults.message.not_created', item: Board.model_name.human) 
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
        #binding.pry
    end
  end
  end

   def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to boards_path
   end
    
  


  def edit
  end

  private

  def board_params
    params.require(:board).permit(:title, :description, :image, :image_cache)
  end
end
