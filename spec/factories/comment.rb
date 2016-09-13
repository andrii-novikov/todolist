FactoryGirl.define do
  factory :comment do
    text {FFaker::LoremUA.paragraph}
    task
  end
end
