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

  scope :ordered, -> { order(created_at: :desc) }

end
