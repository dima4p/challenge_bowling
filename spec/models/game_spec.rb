# == Schema Information
#
# Table name: games
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  state      :string
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Game, type: :model do

  subject { create :game }

  describe 'validations' do
    it { should be_valid }
    it { should have_many :frames }
  end   # validations

  describe 'before_validation' do
    describe '#state' do
      it 'is set to "on"' do
        expect(subject.state).to eq 'on'
      end
    end   #state
  end   # before_validation

  describe 'after_create' do
    it 'adds a Frame to the game' do
      expect{subject}.to change(Frame, :count).by 1
    end
  end   # after_create

  describe '#cancel!' do
    it 'changes the state to "cancelled"' do
      expect(subject.cancel!.state).to eq 'cancelled'
    end

    it 'returns self' do
      expect(subject.cancel!).to eq subject
    end
  end   #cancel!

  describe '#score' do
    let(:frame) {create :frame, score: 5}
    subject {frame.game}

    it 'returns the score of the last frame' do
      expect(subject.score).to eq frame.score
    end
  end   #score

  describe '#score!' do
    it 'adds the score of the game' do
      expect(subject.score!('5').score).to be 5
    end

    it 'returns self' do
      expect(subject.score!(5)).to eq subject
    end

    context 'after last ball' do
      subject {create :game}

      it 'changes state to "finished"' do
        (FRAMES + 2).times {subject.score! PINS}
        expect(subject.reload.state).to eq 'finished'
      end
    end   # after last ball
  end   #score!

  describe 'class methods' do
    describe 'scopes' do
      describe '.ordered' do
        it 'orders the records of Game by :state' do
          create :game
          create :game
          expect(Game.ordered).to eq Game.order(created_at: :desc)
        end
      end   # .ordered
    end   # scopes

    describe '.current' do
      context 'when no game with state "on" exist' do
        it 'returns nil' do
          expect(Game.current).to be_nil
        end
      end   # when no game with state "on" exist

      context 'when a game with state "on" exist' do
        it 'returns it' do
          subject
          expect(Game.current).to eq subject
        end
      end   # when a game with state "on" exist
    end   # .current
  end   # class methods

end
