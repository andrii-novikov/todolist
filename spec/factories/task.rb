# frozen_string_literal: true
FactoryGirl.define do
  factory :task do
    title { FFaker::LoremUA.words(4).join(' ') }
    project
  end
end
