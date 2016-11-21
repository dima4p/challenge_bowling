# == Schema Information
#
# Table name: games
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  state      :string
#  updated_at :datetime         not null
#

# Model Game defines the core of the system with the scoring logic.
#
class Game < ApplicationRecord

  has_many :frames

  before_validation :set_state
  after_create :add_frame

  scope :ordered, -> { order(created_at: :desc) }

  def cancel!
    update state: 'cancelled'
    self
  end

  def score
    current_frame.score
  end

  def score!(pins)
    current_frame.score! pins.to_i
    update state: 'finished' if current_frame.last? and current_frame.done?
    self
  end

  class << self
    def current
      find_by state: 'on'
    end
  end   # class << self

  private

  def add_frame
    frames.create
  end

  def current_frame
    frames.last
  end

  def set_state
    self.state ||= 'on'
  end
end
