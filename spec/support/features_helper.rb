# frozen_string_literal: true
module FeaturesHelper
  def login(user)
    visit '/#login'
    fill_in 'Email', with: user.uid
    fill_in 'Password', with: default_user_password
    click_on 'login'
  end

  def default_user_password
    12_345_678
  end

  def reload
    evaluate_script 'window.location.reload()'
  end
end
