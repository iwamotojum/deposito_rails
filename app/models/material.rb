class Material < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 200 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0}
end
