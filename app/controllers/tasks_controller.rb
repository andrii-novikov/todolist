class TasksController < ApplicationController
  load_and_authorize_resource :project, thorough: :current_user
  load_and_authorize_resource :task

  def create
    @task.save
  end

  def show
  end

  def update
    @task.update(task_params)
  end

  def destroy
    @task.destroy
  end

  def statuses
    @statuses = Task.statuses.keys
  end

  private
  def task_params
    params.fetch(:task).permit(:title, :project_id, :deadline, :done, :status, :order)
  end
end
