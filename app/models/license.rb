class License < ApplicationRecord
  include Paginatable
  include LikeSearchable

  belongs_to :game

  validates :key, presence: true, uniqueness: { case_sensitive: false, scope: :platform }
  validates :status, presence: true
  validates :platform, presence: true

  enum status: { available: 1, in_use: 2, inactive: 3 }
  enum platform: { steam: 1, battle_net: 2, origin: 3 }

end
