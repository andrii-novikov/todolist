class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  def index
    # @projects = Project.all
    puts 'user'
    p current_user
    @projects = current_user.try(:projects) || []
    # pry.binding
  end

  def create
    p project_params
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
