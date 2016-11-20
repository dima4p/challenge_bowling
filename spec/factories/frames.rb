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

FactoryGirl.define do
  factory :frame do
    association :game, factory: :game
    ball1 {rand(0..PINS - 1)}
    ball2 {rand(0..PINS - ball1)}
    ball3 {allow3rd? ? rand(0..PINS) : nil}
    score {ball1.to_i + ball2.to_i + ball3.to_i}
    lack {ball1 == PINS ? 2 : (ball1.to_i + ball2.to_i) == PINS ? 1 : 0}
  end
end
