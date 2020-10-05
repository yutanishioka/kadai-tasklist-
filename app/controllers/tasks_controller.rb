class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    
    def index
        
            @task = current_user.tasks.build  # form_with 用
            @task = current_user.tasks.order(id: :desc).page(params[:page])

    end
    
    def show
    end
    
    def new
        @task = Task.new()
    end
    
    def create
        
       @task = current_user.tasks.build(task_params)
        if @task.save
            flash[:success] = "タスクが正常に追加されました"
            redirect_to @task
        else
            flash.now[:danger] = "タスクが正常に追加されませんでした"
            render :new
        end
    end
    
    def edit
    end
    
    def update
        if @task.update(task_params)
            flash[:success] = "タスクが正常に更新されました"
            redirect_to @task
        else
            flash.now[:danger] = "タスクが正常に更新されませんでした"
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        
        flash[:success] = "タスクは正常に削除されました"
        redirect_to tasks_url
    end
    
    private
    
    def set_task
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
          redirect_to root_url
        end
    end
    
    # Strong Parameter
    def task_params
        params.require(:task).permit(:content, :status)
    end
end
