module FeaturesHelper
  def login(user)
    visit root_path
    click_on 'Log In'
    fill_in 'Email', with: 'a@a.ru'
    fill_in 'Password', with: '12345678'
    click_on 'login'
  end
end
