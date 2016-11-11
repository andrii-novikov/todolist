# frozen_string_literal: true
require 'rails_helper'

feature 'Login page', js: true do
  context 'login with email' do
    context 'invalid credentials' do
      scenario 'show alert "Invalid login credentials. Please try again."' do
        login(build(:user))
        expect(page).to have_css('.alert', text: 'Invalid login credentials. Please try again.')
      end
    end
    context 'valid credentials' do
      let(:user) { create(:user_with_projects, password: default_user_password) }

      scenario 'redirect to home page with projects' do
        login(user)
        expect(page).to have_content('Home')
      end
    end
  end
end
