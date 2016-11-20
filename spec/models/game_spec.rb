require 'rails_helper'

describe Game, type: :model do

  subject { create :game }

  describe 'validations' do
    it { should be_valid }
  end   # validations

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
  end   # class methods

end
