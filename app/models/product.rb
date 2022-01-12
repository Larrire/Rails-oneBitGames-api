class Product < ApplicationRecord
  belongs_to :productable, polymorphic: true
end
