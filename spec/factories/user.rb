FactoryGirl.define do
  factory :user do
    provider 'email'
    email { FFaker::Internet.email }
    uid { FFaker::Internet.email }
    password { FFaker::Internet.password }
  end
end
