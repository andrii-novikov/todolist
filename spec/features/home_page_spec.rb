require 'rails_helper'

feature 'Home page' do
  before do
    visit root_path
  end

  scenario 'visit', js:true do
    expect(page).to have_title 'Todolist'
    expect(page).to have_content 'Todo'
  end
end
