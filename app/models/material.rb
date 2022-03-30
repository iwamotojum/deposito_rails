class Material < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 200 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :material_logs

  def update_quantity!(method, quantity, current_user)
    @quantity = quantity.to_i

    if method == "input" && @quantity.negative?
      errors.add(:quantity, "can't be negative")
      return false

    elsif method == "output" && @quantity.positive?
      errors.add(:quantity, "can't be positive")
      return false

    elsif @quantity.zero?
      errors.add(:quantity, "can't be zero")
      return false
    end

    self.update!(quantity: self.quantity += @quantity)
    self.material_logs.create(material_log_params(method, quantity, current_user))
  end

  private 

  def material_log_params(method, quantity, current_user)
    {
      material_id: self.id,
      user_id: current_user.id,
      method: method,
      quantity: quantity.to_i
    }
  end
end
