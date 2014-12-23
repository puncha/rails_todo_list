class TaskController < ApplicationController
  def index
  end

  def list
    filter = params[:filter] || 'all'
    case filter
      when 'all' then @tasks = Task.all
      when 'completed' then @tasks = Task.completed
      when 'uncompleted' then @tasks = Task.uncompleted
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

  def edit
    id = params[:id]
    @task = Task.find id
  end

  def update
    task = Task.find params[:id]
    if task.update_attributes task_params
      flash[:notice] = 'Task is updated.'
      redirect_to action:'list'
    else
      flash[:errors] = ["Failed to update task '#{task_params[:name]}'."]
      render 'update'
    end
  end

  def delete
    @task = Task.find params[:id]
    if @task.destroy
      flash[:notice] = 'Task is updated.'
    else
      flash[:errors] = ["Failed to update task '#{@task.name}'."]
    end
    redirect_to :action => 'list', :filter=>params[:filter]
  end

  private

    def task_params
      params.require(:task).permit(:name, :completed)
    end

end
