require 'rails_helper'

feature 'Home page', js:true do
  before do
    visit root_path
  end

  context 'Unauthorized user'  do
    scenario 'visit home page' do
      expect(page).to have_title 'Todolist'
      expect(page).to have_content 'Welcome to ToDolists!'
      expect(page).to have_content 'Register'
      expect(page).to have_content 'Log In'
    end
  end

  context 'Authorized user', fix: true  do
    let!(:user) {create(:user_with_projects, uid:'a@a.ru', email: 'a@a.ru', password: '12345678')}

    scenario 'visit home page' do
      login(user)
      expect(page).to have_content 'Log Out'
      expect(page).to have_content(user.projects.first.tasks.first.title)
      expect(page).to have_content(user.projects.last.tasks.last.title)
      expect(page).to have_content('ADD NEW TODO')
    end
  end
end
