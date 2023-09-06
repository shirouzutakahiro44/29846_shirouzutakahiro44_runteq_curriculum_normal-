class BoardsController < ApplicationController

  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end

  def show
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    respond_to do |format|
    if @board.save
      flash[:success] = t('.success')
        format.html { redirect_to login_path, notice: 'Board was successfully created.' }
        format.json { render :show, status: :created, location: @board }
    else
        flash.now[:danger] = t('.fail') 
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
    end
  end
end
  


  def edit
  end

  private

  def board_params
    params.require(:board).permit(:title, :description)
  end
end
