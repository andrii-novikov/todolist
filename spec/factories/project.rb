# frozen_string_literal: true
FactoryGirl.define do
  factory :project do
    title { FFaker::LoremUA.words(2).join(' ') }
    user

    factory :project_with_tasks do
      transient do
        task_count 3
      end

      after(:create) do |project, evaluator|
        create_list(:task, evaluator.task_count, project: project)
      end
    end
  end
end
