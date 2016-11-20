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

# Model Frame defines one frame of a Game
#
class Frame < ApplicationRecord

  belongs_to :game
  belongs_to :previous, class_name: Frame

  before_validation :set_number

  validates :ball1, :ball2, :ball3,
      inclusion: {in: (0..PINS).to_a, allow_nil: true}

  scope :ordered, -> { order(:created_at) }

  def allow1st?
    ball1.blank?
  end

  def allow2nd?
    not allow1st? and ball2.blank? and
        (not strike? or last?)
  end

  def allow3rd?
    last? and (strike? or spare?) and ball3.blank?
  end

  def done?
    not (allow1st? or allow2nd? or allow3rd?)
  end

  def last?
    number == FRAMES
  end

  def score!(pins, stop = nil)
    raise 'Frame is closed' if done?
    transaction do
      self.score += pins
      self.score += update_previous! pins if previous
      case
      when allow1st? then self.ball1 = pins
      when allow2nd? then self.ball2 = pins
      when allow3rd? then self.ball3 = pins
      end   # case
      self.lack = 2 if strike?
      self.lack = 1 if spare?
      save!
      self.class.create previous: self, game: game, score: score unless last? if done?
    end   # transaction
  end

  def spare?
    not strike? and ball1.to_i + ball2.to_i == PINS
  end

  def strike?
    ball1 == PINS
  end

  private

  def set_number
    self.number ||= previous&.number.to_i + 1
  end

  def update_previous!(pins, stop = nil)
    return 0 unless previous
    increment = 0
    if previous.lack > 0
      previous.lack -=1
      previous.score += pins
      increment += pins
      previous.save!
    end   # lack > 0
    increment += previous.send :update_previous!, pins, true unless stop
    increment
  end
end
