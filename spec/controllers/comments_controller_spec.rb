require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let!(:project) { create(:project_with_tasks, user:user) }
  let!(:task) { project.tasks.first }
  let!(:comment) { create(:comment, task:task) }

  before do
    allow(controller).to receive(:current_user) {user}
  end

  describe 'POST create' do
    let(:attrs) {attributes_for(:comment, task:task)}
    before do
      post :create, format: :json, params: attrs.merge(task_id: task.id)
    end

    it 'render :create' do
      expect(response).to render_template(:create)
    end

    it 'assign @comment with new params' do
      expect(assigns(:comment).text).to eq attrs[:text]
    end
  end

  describe 'PUT update' do
    let(:new_text) {'new_text'}
    before do
      put :update,
          format: :json,
                params: { id:comment.id, text: new_text, task_id: task.id}
    end

    it 'render :update'do
      expect(response).to render_template(:update)
    end

    it 'update project' do
      expect(assigns(:comment).text).to eq new_text
    end
  end

  describe 'DELETE destroy' do
    let(:action) do
      post :destroy, format: :json, params: { id:comment.id, task_id: task.id }
    end

    it 'render :destroy' do
      action
      expect(response).to render_template(:destroy)
    end

    it 'delete project' do
      expect {action}.to change {task.comments.count}.by(-1)
    end
  end
end
