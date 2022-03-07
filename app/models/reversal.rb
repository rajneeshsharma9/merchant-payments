class Reversal < Transaction

  belongs_to :authorized_transaction, class_name: 'AuthorizeTransaction', foreign_key: :transaction_id

  # Callbacks
  before_validation :copy_authorized_transaction_data
  before_create :check_parent_transaction_status
  after_create :update_authorized_transaction

  private

  # Only approved or refunded transactions can be referenced, otherwise the submitted transaction will be created with status error
  def check_parent_transaction_status
    self.status = 'error' unless authorized_transaction.approved? || authorized_transaction.refunded?
  end

  def update_authorized_transaction
    authorized_transaction.update(status: 'reversed')
  end

  def copy_authorized_transaction_data
    [:customer_email, :customer_phone, :merchant_id].each do |attribute|
      self[attribute] = authorized_transaction[attribute] unless self[attribute].present?
    end
    self.amount = authorized_transaction.amount
  end
end
