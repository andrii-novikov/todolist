# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to belong_to :task }
  it { is_expected.to validate_presence_of :text }
  it { is_expected.to validate_presence_of :task_id }
  it { is_expected.to delegate_method(:user).to :task }
  it { is_expected.to delegate_method(:project).to :task }
end
