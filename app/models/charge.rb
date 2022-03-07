class Charge < Transaction

  # Associations
  belongs_to :authorized_transaction, class_name: 'AuthorizeTransaction', foreign_key: :transaction_id
  has_one :refund, class_name: 'Refund', foreign_key: :transaction_id

  # Callbacks
  before_validation :copy_authorized_transaction_data
  before_save :check_parent_transaction_status
  after_save :update_merchant_transaction_sum, if: :approved?

  # Validations
  validates :amount, numericality: { greater_than_or_equal_to: 0.0 }

  private

  # Only approved or refunded transactions can be referenced, otherwise the submitted transaction will be created with status error
  def check_parent_transaction_status
    self.status = 'error' unless authorized_transaction.approved? || authorized_transaction.refunded?
  end

  def update_merchant_transaction_sum
    merchant.recalculate_transaction_sum
  end

  def copy_authorized_transaction_data
    [:customer_email, :customer_phone, :merchant_id].each do |attribute|
      self[attribute] = authorized_transaction[attribute] unless self[attribute].present?
    end
    self.amount = authorized_transaction.amount
  end

end
