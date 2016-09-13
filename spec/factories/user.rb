# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    provider 'email'
    email { FFaker::Internet.email }
    uid { FFaker::Internet.email }
    password { '12345678' }

    factory :user_with_projects do
      transient do
        project_count 3
      end

      after(:create) do |user, evaluator|
        create_list(:project_with_tasks, evaluator.project_count, user: user)
      end
    end
  end
end
