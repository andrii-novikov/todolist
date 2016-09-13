class ProjectsController < ApplicationController
  load_and_authorize_resource
  before_action :set_project, only: [:show, :update, :destroy]

  def index
   @projects = current_user.try(:projects) || []
  end

  def create
    @project = Project.create(project_params)
  end

  def show
  end

  def update
    @project.update(project_params)
  end

  def destroy
    @project.destroy
  end

  private

  def project_params
    params.require(:project).permit(:title).merge(user:current_user)
  end

  def set_project
    @project = Project.find_by_id(params[:id])
  end
end
