class Refund < Transaction

  # Associations
  belongs_to :charge, class_name: 'Charge', foreign_key: :transaction_id

  # Callbacks
  before_validation :copy_charge_data
  before_save :check_charge_status
  after_create :update_charge
  after_save :update_merchant_transaction_sum, if: :approved?

  # Validations
  validates :amount, numericality: { greater_than_or_equal_to: 0.0 }

  private

  # Only approved or refunded transactions can be referenced, otherwise the submitted transaction will be created with status error
  def check_charge_status
    self.status = 'error' unless charge.approved? || charge.refunded?
  end

  def update_merchant_transaction_sum
    merchant.recalculate_transaction_sum
  end

  def update_charge
    charge.update(status: 'refunded')
  end

  def copy_charge_data
    [:customer_email, :customer_phone, :merchant_id].each do |attribute|
      self[attribute] = charge[attribute] unless self[attribute].present?
    end
    self.amount = charge.amount
  end

end
