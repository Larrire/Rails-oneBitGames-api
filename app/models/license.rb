class License < ApplicationRecord
  validates :key, presence: true, uniqueness: { case_sensitive: false }
  # validates :game, presence: true
  belongs_to :game
end
