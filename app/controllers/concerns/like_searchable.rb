module LikeSearchable
  extend ActiveSupport::Concern

  included do
    scope :like, -> (key, value) do
      # self.where("#{key} ILIKE ?", "%#{value}%")
      self.where(self.arel_table[key].matches("%#{value}%"))
    end
  end
end