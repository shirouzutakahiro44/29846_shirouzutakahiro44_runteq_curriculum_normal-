class BoardsController < ApplicationController

  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show
    @board = Board.find(params[:id])
    @comments = @board.comments.includes(:user).order(created_at: :desc)
    @comment = current_user.comments.new
    @comment.board_id == @board.id
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
    @board = current_user.boards.find(params[:id])
    @board.destroy!
    redirect_to boards_path, success: t('.success')
   end
    
  


  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = current_user.board.find(params[:id])
    if @board.update(board_params)
      redirect_to board_path,success: t('.success')
    else
      render 'edit'
    end
  end

  def bookmarks
    @q = current_user.bookmarks_boards.ransack(params[:q])
    @bookmark_boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
    #@bookmark_boards = current_user.bookmarks_boards.includes(:user).order(created_at: :desc).page(params[:page])
  end

  private

  def board_params
    params.require(:board).permit(:title, :description, :image, :image_cache)
  end
end
