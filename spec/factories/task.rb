FactoryGirl.define do
  factory :task do
    title {FFaker::LoremUA.words(4).join(' ')}
    project
  end
end
