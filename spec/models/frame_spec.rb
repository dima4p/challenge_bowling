# == Schema Information
#
# Table name: frames
#
#  ball1       :integer
#  ball2       :integer
#  ball3       :integer
#  created_at  :datetime         not null
#  game_id     :integer
#  id          :integer          not null, primary key
#  lack        :integer          default(0)
#  number      :integer
#  previous_id :integer
#  score       :integer          default(0)
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_frames_on_game_id      (game_id)
#  index_frames_on_previous_id  (previous_id)
#

require 'rails_helper'

describe Frame, type: :model do

  subject { create :frame }

  describe 'before_validation' do
    describe '#number' do
      context 'when no #previous is given' do
        it 'is set to 1' do
          expect(subject.number).to be 1
        end
      end   # when no #previous is given

      context 'when no #previous is given' do
        subject { create :frame, previous: create(:frame, number: 5) }

        it 'is set to the next after previous' do
          expect(subject.number).to be 6
        end
      end   # when no #previous is given
    end   #number
  end   # before_validation

  describe 'validations' do
    it { should be_valid }
    it { should belong_to :game }
    it { should belong_to(:previous).class_name Frame }
    it { should validate_inclusion_of(:ball1).in_array((0..PINS).to_a).allow_nil }
    it { should validate_inclusion_of(:ball2).in_array((0..PINS).to_a).allow_nil }
    it { should validate_inclusion_of(:ball3).in_array((0..PINS).to_a).allow_nil }
  end   # validations

  describe '#allow1st?' do
    subject {create(:frame, ball1: ball1, ball2: nil, ball3: nil).allow1st?}
    let(:ball1) {}

    context 'when a ball is recorded' do
      let(:ball1) {1}

      it 'returns false' do
        expect(subject).to be false
      end
    end   # when a ball is recorded

    context 'when no ball is recorded' do
      it 'returns true' do
        expect(subject).to be true
      end
    end   # when no ball is recorded
  end   #allow1st?

  describe '#allow2nd?' do
    subject {create(:frame, ball1: ball1, ball2: ball2, ball3: nil).allow2nd?}
    let(:ball1) {}
    let(:ball2) {}

    context 'when no ball is scored?' do
      it 'returns false' do
        expect(subject).to be false
      end
    end   # when no ball is scored?

    context 'when one ball is scored?' do
      context 'without strike' do
        let(:ball1) {1}

        context 'and second ball is recorded' do
          let(:ball2) {1}

          it 'returns false' do
            expect(subject).to be false
          end
        end   # and second ball is recorded

        context 'and second ball is not recorded' do
          it 'returns true' do
            expect(subject).to be true
          end
        end   # and second ball is recorded
      end   # without strike

      context 'with strike' do
        let(:ball1) {PINS}

        it 'returns false' do
          expect(subject).to be false
        end
      end   # with strike
    end   # when one ball is scored?
  end   #allow2nd?

  describe '#allow3rd?' do
    subject {create(:frame, number: number, ball1: ball1, ball2: ball2).allow3rd?}
    let(:ball1) {PINS}
    let(:ball2) {}

    context 'wnen not last?' do
      let(:number) {FRAMES - 1}

      it 'returns false' do
        expect(subject).to be false
      end
    end   # wnen not last?

    context 'wnen  last?' do
      let(:number) {FRAMES}

      context 'and strike?' do
        it 'returns true' do
          expect(subject).to be true
        end
      end   # and strike?

      context 'and spare?' do
        let(:ball1) {PINS - 3}
        let(:ball2) {3}

        it 'returns true' do
          expect(subject).to be true
        end
      end   # and spare?

      context 'and not spare? nor strike?' do
        let(:ball1) {PINS - 3}
        let(:ball2) {2}

        it 'returns false' do
          expect(subject).to be false
        end
      end   # and not spare? nor strike?
    end   # wnen not last?
  end   #allow3rd?

  describe '#done?' do
    context 'wnen not last?' do
      subject {create(:frame, ball1: ball1, ball2: ball2, ball3: nil).done?}
      let(:ball1) {}
      let(:ball2) {}

      context 'and no ball is scored' do
        it 'returns false' do
          expect(subject).to be false
        end
      end   # and no ball is scored

      context 'and one ball is scored' do
        context 'with strike' do
          let(:ball1) {PINS}

          it 'returns true' do
            expect(subject).to be true
          end
        end   # with strike

        context 'without strike' do
          let(:ball1) {1}

          context 'while second ball is not scored' do
            it 'returns false' do
              expect(subject).to be false
            end
          end   # while second ball is not scored

          context 'and second ball is scored' do
            let(:ball2) {1}

            it 'returns true' do
              expect(subject).to be true
            end
          end   # and second ball is scored
        end   # without strike
      end   # and one ball is scored
    end   # wnen not last?

    context 'when last?' do
      subject {create(:frame, number: FRAMES, ball1: ball1, ball2: ball2, ball3: ball3).done?}
      let(:ball1) {}
      let(:ball2) {}
      let(:ball3) {}

      context 'and no ball is scored' do
        it 'returns false' do
          expect(subject).to be false
        end
      end   # and no ball is scored

      context 'and one ball is scored' do
        context 'with strike' do
          let(:ball1) {PINS}
          let(:ball2) {PINS}

          context 'while third ball is not scored' do
            it 'returns false' do
              expect(subject).to be false
            end
          end   # while third ball is not scored

          context 'and third ball is scored' do
            let(:ball3) {PINS}

            it 'returns true' do
              expect(subject).to be true
            end
          end   # and third ball is scored
        end   # with strike

        context 'without strike' do
          let(:ball1) {PINS - 2}

          context 'while second ball is not scored' do
            it 'returns false' do
              expect(subject).to be false
            end
          end   # while second ball is not scored

          context 'and second ball is scored' do
            let(:ball2) {1}

            context 'without spare' do
              it 'returns true' do
                expect(subject).to be true
              end
            end   # without spare

            context 'with spare' do
              let(:ball2) {2}

              context 'while third ball is not scored' do
                it 'returns false' do
                  expect(subject).to be false
                end
              end   # while third ball is not scored

              context 'and third ball is scored' do
                let(:ball3) {PINS}

                it 'returns true' do
                  expect(subject).to be true
                end
              end   # and third ball is scored
            end   # with spare
          end   # and second ball is scored
        end   # without strike
      end   # and one ball is scored
    end   # when last?
  end   #done?

  describe '#last?' do
    subject {create(:frame, number: number).last?}

    context "when number < #{FRAMES}" do
      let(:number) {FRAMES - 1}

      it 'returns false' do
        expect(subject).to be false
      end
    end   # when number < #{FRAMES}

    context "when number == #{FRAMES}" do
      let(:number) {FRAMES}

      it 'returns true' do
        expect(subject).to be true
      end
    end   # when number == #{FRAMES}
  end   #last?

  describe '#score!' do
    subject {create :frame, ball1: ball1, ball2: ball2, ball3: ball3, number: number}
    let(:ball1) {}
    let(:ball2) {}
    let(:ball3) {}
    let(:number) {1}

    it 'raises when done' do
      expect(subject).to receive(:done?).and_return true
      expect{subject.score! 0}.to raise_exception 'Frame is closed'
    end

    it 'increases the score by argument passed' do
      expect{subject.score! 5}.to change(subject, :score).by 5
    end

    describe 'saves each ball result' do
      context 'for the first ball' do
        it 'is stored to ball1' do
          expect{subject.score! 5}.to change(subject, :ball1).to 5
        end
      end   # for the first ball

      context 'for the second ball' do
        let(:ball1) {1}
        it 'is stored to ball2' do
          expect{subject.score! 5}.to change(subject, :ball2).to 5
        end
      end   # for the second ball

      context 'for the third ball' do
        let(:ball1) {PINS}
        let(:ball2) {PINS}
        let(:number) {FRAMES}
        it 'is stored to ball3' do
          expect{subject.score! 5}.to change(subject, :ball3).to 5
        end
      end   # for the third ball
    end   # saves each ball result

    context 'when strike?' do
      it 'sets 2 to lack' do
        expect{subject.score! PINS}.to change(subject, :lack).to 2
      end
    end   # strike?

    context 'when spare?' do
      let(:ball1) {PINS - 1}

      it 'sets 1 to lack' do
        expect{subject.score! 1}.to change(subject, :lack).to 1
      end
    end   # spare?

    context 'when not strike? nor spare?' do
      let(:ball1) {PINS - 2}

      it 'sets 1 to lack' do
        expect{subject.score! 1}.not_to change(subject, :lack)
      end
    end   # not spare? nor spare?

    describe 'after the frame is over' do
      context 'if it is the last one' do
        let(:number) {FRAMES}

        it 'does not create the following frame' do
          subject
          expect{subject.score! PINS}.not_to change(Frame, :count)
        end
      end

      context 'if it is not the last one' do
        it 'creates the following frame' do
          subject
          expect{subject.score! PINS}.to change(subject.game.frames, :count).by 1
          expect(Frame.last.previous).to eq subject
          expect(Frame.last.score).to be subject.score
        end
      end
    end   # after the frame is over

    describe 'the following' do
      it '2 next calls increase score if strike' do
        subject.score! PINS
        expect(subject.score).to be PINS
        Frame.last.score! 1
        expect(subject.reload.score).to be PINS + 1
        Frame.last.score! 1
        expect(subject.reload.score).to be PINS + 2
        Frame.last.score! 1
        expect(subject.reload.score).to be PINS + 2
        expect(Frame.last.score).to eq PINS + 5
      end   # 2 next calls increase score if strike

      it 'one next call increases score if spare' do
        subject.score! PINS - 1
        subject.score! 1
        expect(subject.score).to be PINS
        Frame.last.score! 1
        expect(subject.reload.score).to be PINS + 1
        Frame.last.score! 1
        expect(subject.reload.score).to be PINS + 1
        expect(Frame.last.score).to eq PINS + 3
      end   # one next call increases score if spare
    end   # the following
  end   #score!

  describe '#spare?' do
    subject {create(:frame, ball1: ball1, ball2: ball2, ball3: ball3).spare?}
    let(:ball1) {}
    let(:ball2) {}
    let(:ball3) {}

    context 'when no balls recorded' do
      it 'returns false' do
        expect(subject).to be false
      end
    end   # when no balls recorded

    context "when first ball hits exactly #{PINS} pins" do
      let(:ball1) {PINS}

      it 'returns false' do
        expect(subject).to be false
      end
    end   # when first ball hits exactly #{PINS} pins

    context "when first ball hits less than #{PINS} pins" do
      let(:ball1) {PINS - 2}

      context "when second ball is not recorded" do
        it 'returns false' do
          expect(subject).to be false
        end
      end   # when second ball is not recorded

      context 'when a pin is left' do
        let(:ball2) {1}


        it 'returns false' do
          expect(subject).to be false
        end
      end   # when a pin is left

      context 'when all pins are hit' do
        let(:ball2) {2}

        it 'returns true' do
          expect(subject).to be true
        end
      end   # when all pins are hit
    end   # when first ball hits less than #{PINS} pins
  end   #spare?

  describe '#strike?' do
    subject {create(:frame, ball1: ball1, ball2: ball2, ball3: ball3).strike?}
    let(:ball1) {}
    let(:ball2) {}
    let(:ball3) {}

    context 'when no balls recorded' do
      it 'returns false' do
        expect(subject).to be false
      end
    end   # when no balls recorded

    context "when first ball hits less than #{PINS} pins" do
      let(:ball1) {PINS - 1}

      it 'returns false' do
        expect(subject).to be false
      end
    end   # when first ball hits less than #{PINS} pins

    context "when first ball hits exactly #{PINS} pins" do
      let(:ball1) {PINS}

      it 'returns true' do
        expect(subject).to be true
      end
    end   # when first ball hits exactly #{PINS} pins
  end   #strike?

  describe 'class methods' do
    describe 'scopes' do
      describe '.ordered' do
        it 'orders the records of Frame by :game' do
          create :frame
          create :frame
          expect(Frame.ordered).to eq Frame.order(:created_at)
        end
      end   # .ordered
    end   # scopes
  end   # class methods

end
