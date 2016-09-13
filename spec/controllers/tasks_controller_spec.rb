require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) {create(:user)}
  let!(:project) {create(:project_with_tasks, user:user)}
  let(:task) {project.tasks.first}

  before do
    allow(controller).to receive(:current_user) {user}
  end

  describe 'GET show' do
    before do
      get :show,
          format: :json,
          params: { id: task.id }
    end

    it 'render :show' do
      expect(response).to render_template(:show)
    end

    it 'assign @task' do
      expect(assigns(:task)).to eq task
    end
  end

  describe 'POST create' do
    let(:attrs) {attributes_for(:task, project_id:project.id)}
    before do
      post :create, format: :json, params: {task: attrs}
    end

    it 'render :create' do
      expect(response).to render_template(:create)
    end

    it 'assign @task with new params' do
      expect(assigns(:task).title).to eq attrs[:title]
    end
  end

  describe 'PUT update' do
    let(:new_title) {'new_title'}
    before do
      put :update,
          format: :json,
          params: { id:task.id, task: { title: new_title }}
    end

    it 'render :update'do
      expect(response).to render_template(:update)
    end

    it 'update task' do
      expect(assigns(:task).title).to eq new_title
    end
  end

  describe 'DELETE destroy' do
    let(:action) do
      post :destroy, format: :json, params: {id:task.id}
    end

    it 'render :destroy' do
      action
      expect(response).to render_template(:destroy)
    end

    it 'delete task' do
      expect {action}.to change {project.tasks.count}.by(-1)
    end
  end

  describe 'GET statuses' do
    before do
      get :statuses, format: :json
    end

    it 'render :statuses' do
      expect(response).to render_template(:statuses)
    end

    it 'assign @statuses' do
      expect(assigns(:statuses)).to be_a Array
      expect(assigns(:statuses)).not_to be_empty
    end
  end
end
