class TasksController < ApplicationController
  respond_to :html, :xml, :json
  skip_before_filter :verify_authenticity_token, if: :json_request?
  before_action :check_logged_in, :except => []

  def index
    filter = params[:filter] || 'all'
    case filter
      when 'all' then @tasks = Task.all
      when 'completed' then @tasks = Task.completed
      when 'uncompleted' then @tasks = Task.uncompleted
      else @tasks = []
    end

    respond_with @tasks
  end

  def show
    respond_with do |format|
      format.json { render :json => Task.all }
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new task_params
    if @task.save
      flash[:notice] = "New task '#{task_params[:name]}' created."
    else
      flash[:errors] = ["Failed to create new task '#{task_params[:name]}'."]
      flash[:errors] += @task.errors.full_messages
    end
    respond_with @task, location: tasks_path
  end

  def edit
    id = params[:id]
    @task = Task.find id
  end

  def update
    @task = Task.find params[:id]
    if @task.update_attributes task_params
      flash[:notice] = 'Task is updated.'
    else
      flash[:errors] = ["Failed to update task '#{task_params[:name]}'."]
      flash[:errors] += @task.errors.full_messages
    end
    respond_with @task, location: tasks_path do |format|
      format.json { render :json => {bab:'god'}.to_json }
    end
  end

  def delete
    @task = Task.find params[:id]
    succ = @task.destroy
    if succ
      flash[:notice] = 'Task is deleted.'
    else
      flash[:errors] = ["Failed to delete task '#{@task.name}'."]
      flash[:errors] += task.errors.full_messages
    end
    respond_to do |format|
      format.html { redirect_to tasks_url(filter:params[:filter]) }
      format.json { return {:result=>succ} }
    end
  end

  def destroy
    delete
  end


  private

  def task_params
    params.require(:task).permit(:name, :completed)
  end

  def json_request?
    request.accepts.each do |content_type|
      if content_type == 'application/html' or content_type == 'application/xml'
          return false
      elsif 'application/json'
        return true
      end
    end
    return false
  end

end
