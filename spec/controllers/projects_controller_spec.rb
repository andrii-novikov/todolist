# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create(:user) }
  let!(:project) { create(:project, user: user) }

  before do
    allow(controller).to receive(:current_user) { user }
  end

  describe 'GET index' do
    before { get :index, format: :json }

    it 'render :index' do
      expect(response).to render_template(:index)
    end

    it 'assign @projects from current user' do
      expect(assigns(:projects)).to eq user.projects
    end
  end

  describe 'GET show' do
    before do
      get :show,
          format: :json,
          params: { id: project.id }
    end

    it 'render :show' do
      expect(response).to render_template(:show)
    end

    it 'assign @project' do
      expect(assigns(:project)).to eq project
    end
  end

  describe 'POST create' do
    let(:attrs) { attributes_for(:project) }
    before do
      post :create, format: :json, params: { project: attrs }
    end

    it 'render :create' do
      expect(response).to render_template(:create)
    end

    it 'assign @project with new params' do
      expect(assigns(:project).title).to eq attrs[:title]
    end
  end

  describe 'PUT update' do
    let(:new_title) { 'new_title' }
    before do
      put :update,
          format: :json,
          params: { id: project.id, project: { title: new_title } }
    end

    it 'render :update' do
      expect(response).to render_template(:update)
    end

    it 'update project' do
      expect(assigns(:project).title).to eq new_title
    end
  end

  describe 'DELETE destroy' do
    let(:action) do
      post :destroy, format: :json, params: { id: project.id }
    end

    it 'render :destroy' do
      action
      expect(response).to render_template(:destroy)
    end

    it 'delete project' do
      expect { action }.to change { user.projects.count }.by(-1)
    end
  end
end
