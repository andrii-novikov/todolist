# frozen_string_literal: true
class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :user, presence: true
  validates :title, presence: true
end
