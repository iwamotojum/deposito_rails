class MaterialLog < ApplicationRecord
  validates :quantity, :method, :material_id, :user_id, presence: true
  validates :method, inclusion: { in: %w(input output), message: "%{value} is not valid."}

  belongs_to :material
  belongs_to :user
end
