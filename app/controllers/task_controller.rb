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
    @task = Task.new
  end

  def create
    if Task.create task_params()
      flash[:notice] = "New task '#{task_params[:name]}' created."
      redirect_to action:'list'
    else
      flash[:errors] = ["Failed to create new task '#{task_params[:name]}'."]
      render 'new'
    end
  end


  def delete
  end

  def destroy
  end

  def update
  end

  def edit
  end

  private

    def task_params
      params.require(:task).permit(:name, :completed)
    end

end
