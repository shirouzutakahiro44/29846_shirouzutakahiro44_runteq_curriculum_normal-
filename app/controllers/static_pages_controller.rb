class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top]
  
  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def top
  end
end
