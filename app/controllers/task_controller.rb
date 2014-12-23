class TaskController < ApplicationController
  def index
  end

  def list
    filter = params[:filter] || 'all'
    case filter
      when 'all' then @tasks = Task.all
      when 'completed' then @tasks = Task.where completed: true
      when 'uncompleted' then @tasks = Task.where completed: false
    end
  end

  def show
  end

  def new
  end

  def create
  end

  def delete
  end

  def destroy
  end

  def update
  end

  def edit
  end
end
