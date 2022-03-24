class Material < ApplicationRecord
  validates :quantidade, numericality: { greater_than_or_equal_to: 0 }
end
