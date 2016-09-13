# frozen_string_literal: true
require 'rails_helper'

feature 'Projects page', js: true do
  let!(:user) { create(:user_with_projects, password: default_user_password) }
  let(:project) { user.projects.first }
  let(:task) { project.tasks.first }

  before { login(user) }

  context 'can delete' do
    scenario 'task' do
      expect { all('task-container .glyphicon-trash').first.click }
        .to change { sleep 1; all('task-container').count }.by(-1)
    end

    scenario 'project' do
      expect { all('.project .panel-heading .glyphicon-trash').first.click }
        .to change { sleep 1; all('project-container').count }.by(-1)
    end
  end

  context 'can create new' do
    scenario 'task' do
      within(".project[id='1']") do
        fill_in 'newTask', with: 'New Task'
        click_on 'Add'
        expect(page).to have_css('task-container .text a', text: 'New Task')
      end
    end

    scenario 'project' do
      click_on 'addProject'
      expect do
        within '.modal' do
          fill_in 'title', with: 'New Project'
          find('.btn-primary').click
        end
      end
        .to change { sleep 1; all('.project').count }.by(1)
    end
  end

  context 'can edit' do
    scenario 'task' do
      sleep 2
      find("task-container[id='#{task.id}'] .glyphicon-edit").click
      expect(page). to have_content 'Task'
      expect(page). to have_css('h2', text: task.title.mb_chars.capitalize.to_s)
    end

    scenario 'project' do
      sleep 1
      within ".project[id='#{project.id}']" do
        find('.glyphicon-pencil').click
        find('.title').set('new Title')
      end
      find('body').click
      reload
      sleep 1
      within ".project[id='#{project.id}']" do
        expect(find('.title').value).to eq 'new Title'
      end
    end
  end
end
