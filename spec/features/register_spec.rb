require 'rails_helper'

feature 'Register page', js:true do
  let(:attrs) {attributes_for :user}
  let(:user) {create(:user)}
  before  { visit '/#/register' }

  context 'valid data' do
    before  do
      fill_in('Email', with: attrs[:uid])
      fill_in('Password', with: attrs[:password])
      click_on 'register'
    end

    scenario 'redirect to home page' do
      expect(page).to have_content('Home')
    end
    scenario 'logout button show' do
      expect(page).to have_content 'Log Out'
    end
  end

  context 'invalid data' do
    before do
      fill_in('Email', with: user.uid)
      fill_in('Password', with: user.password)
      click_on 'register'
    end

    context 'email already in use' do
      scenario 'show alert' do
        expect(page).to have_css('.help-block', text: 'Email already in use')
      end

      scenario 'add class .has-error to email' do
        expect(page).to have_css('.email.has-error')
      end
    end

    context 'password to short' do
      before do
        fill_in('Email', with: attrs[:uid])
        fill_in('Password', with: 123)
        click_on 'register'
      end

      scenario 'show alert' do
        expect(page).to have_css('.help-block', text: 'Password is too short (minimum is 8 characters)')
      end

      scenario 'add class .has-error to password' do
        expect(page).to have_css('.password.has-error')
      end
    end
  end
end
