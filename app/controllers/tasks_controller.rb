class TasksController < ApplicationController
  authorize_resource
  before_action :set_task, only: [:show, :update, :destroy]

  def create
    @task = Task.create(task_params)
  end

  def show
    authorize! :show, @task
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
    params.fetch(:task,{}).permit(:title, :project_id, :deadline, :done, :status, :order)
  end

  def set_task
    @task = Task.find_by_id(params[:id])
  end
end
