require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability do
  let(:user) { create(:user) }

  context 'user' do
    subject(:ability) { Ability.new(user) }
    it {is_expected.to be_able_to :manage, Project, user:user}
    it {is_expected.to be_able_to :manage, Task, user:user}
    it {is_expected.to be_able_to :manage, Comment, user:user}
  end

  context 'not log in' do
    subject(:ability) { Ability.new(nil) }
    it {is_expected.not_to be_able_to :manage, Project, user:user}
    it {is_expected.not_to be_able_to :manage, Task, user:user}
    it {is_expected.not_to be_able_to :manage, Comment, user:user}
  end
end
