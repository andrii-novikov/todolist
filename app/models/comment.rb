class Comment < ApplicationRecord
  mount_uploader :attachment, FileUploader
  belongs_to :task
  validates :text, presence: true
  validates :task_id, presence: true

  delegate :user, to: :task
  delegate :project, to: :task
end
