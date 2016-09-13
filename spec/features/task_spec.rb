# frozen_string_literal: true
require 'rails_helper'

feature 'Task page', js: true do
  let!(:user) { create(:user_with_projects, password: default_user_password) }
  let(:project) { user.projects.first }
  let(:task) { project.tasks.first }
  let!(:comment) { create(:comment, task: task) }

  before do
    login(user)
    sleep 1
    find("task-container[id='#{task.id}'] .glyphicon-edit").click
    sleep 1
  end

  context 'task edit' do
    scenario 'update info' do
      within 'task-detail-container' do
        find('input.title').set('new Title')
      end
      find('body').click
      reload
      within 'task-detail-container' do
        expect(find('.title').value).to eq 'new Title'
      end
    end

    scenario 'can change and update deadline' do
      within 'task-detail-container' do
        find('.btn.deadline').click
        expect { find('.uib-datepicker-popup .btn', text: Date.tomorrow.day).click }.to change { find('input.deadline').value }
        expect { reload }.not_to change { find('input.deadline').value }
      end
    end
  end

  scenario 'go back' do
    find('.btn.go-back').click
    expect(page).to have_content('Home')
    expect(page).to have_content(task.title)
  end

  scenario 'delete task and redirect to home page' do
    find('.btn.delete').click
    expect(page).to have_content('Home')
    expect(page).not_to have_content(task.title)
  end

  context 'comments' do
    scenario 'can place comment' do
      text = FFaker::Lorem.paragraph
      find('.comment-text').set(text)
      expect { find('.place-comment').click }.to change { sleep 1; find_all('.comment').count }.by(1)
      expect(find('.comment-text').value).to be_empty
      expect(page).to have_content(text)
    end

    scenario 'can delete comment' do
      expect { find('.comments i.delete').click }.to change { sleep 1; find_all('.comment').count }.by(-1)
    end

    scenario 'can upload file' do
      text = FFaker::Lorem.paragraph
      find('.comment-text').set(text)
      find('[id=fileInput]', visible: false).set(Rails.root + '.rspec')
      expect { find('.place-comment').click }.to change { sleep 1; find_all('.comment').count }.by(1)
      expect(find('.comment-text').value).to be_empty
      expect(page).to have_content(text)
      expect(page).to have_css('a.btn[download]')
    end
  end
end
