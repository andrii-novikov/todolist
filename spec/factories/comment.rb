# frozen_string_literal: true
FactoryGirl.define do
  factory :comment do
    text { FFaker::LoremUA.paragraph }
    task
  end
end
