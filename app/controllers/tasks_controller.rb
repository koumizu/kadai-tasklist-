class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:show, :edit,:update, :destroy]
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    
    def index
       
        @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
    
    def show 
        
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = "Taskが正常に投稿されました！"
            redirect_to @task
        else
            @tasks = current_user.tasks.order(id: :desc).page(params[:page])
            flash.now[:danger] = "Taskが投稿されませんでした！"
             render 'tasks/new'
        end
    end
    
    def edit
       
    end
    
    def update
     
        if @task.update(task_params)
            flash[:success] = "Taskが正常に更新されました！"
            redirect_to("/")
        else 
            flash.now[:danger] = "Taskが更新されませんでした！"
            render :edit
        end
    end
    
    def destroy
        
        @task.destroy
        
        flash[:success] = "タスクは正常に削除されました！"
        redirect_back(fallback_location: "/")
    end
    
    private
    
    def set_task
        @task = Task.find_by(id: params[:id])
    end
    
    def task_params
        params.require(:task).permit(:content, :status)
    end
    
    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
        redirect_to("/")
      end
    end
  
end
