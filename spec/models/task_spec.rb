require 'rails_helper'

RSpec.describe Task, type: :model do
  it {is_expected.to belong_to :project}
  it {is_expected.to have_many(:comments).dependent(:destroy)}
  it {is_expected.to validate_presence_of :title}
  it {is_expected.to validate_presence_of :status}
  it {is_expected.to delegate_method(:user).to :project}
  it {is_expected.to define_enum_for :status}

  describe '#order' do
    it 'return integer' do
      expect(subject.order).to be_a Integer
    end
  end

  describe '#order_up' do
    context 'when very_important' do
      it 'return false' do
        allow(subject).to receive(:very_important?) {true}
        expect(subject.order_up).to eq false
      end
    end

    context 'when not very_important' do
      before { allow(subject).to receive(:very_important?) {false} }

      it 'change status' do
        expect {subject.order_up}.to change {subject.status}
      end

      it 'increase order' do
        expect {subject.order_up}.to change {subject.order}.by(1)
      end
    end
  end

  describe '#order_down' do
    context 'when unimportant' do
      it 'return false' do
        allow(subject).to receive(:unimportant?) {true}
        expect(subject.order_down).to eq false
      end
    end

    context 'when not unimportant' do
      before { allow(subject).to receive(:unimportant?) {false} }

      it 'change status' do
        expect {subject.order_down}.to change {subject.status}
      end

      it 'decrease order' do
        expect {subject.order_down}.to change {subject.order}.by(-1)
      end
    end
  end
end
