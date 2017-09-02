class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
   @task = current_user.task.order(created_at: :desc).page(params[:page])
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = 'タスクが正常に追加されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが追加されませんでした'
      render :new
    end
  end

  def edit
  end

  def update

    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
    flash.now[:danger] = 'タスクは更新されませんでした'
    render :edit
    end  
  end

  def destroy
    @task.destroy
    
    flash[:success] = "タスクは正常に削除されました"
    redirect_to tasks_url
    
  end

  private
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status, :user_id)
  end
  
  def set_task
     @task = Task.find(params[:id])
     user = @task.user
     if (current_user != user)
       redirect_to root_url
     end
  end
  
end