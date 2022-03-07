class AuthorizeTransaction < Transaction

  # Associations
  has_one :charge, class_name: 'Charge', foreign_key: :transaction_id
  has_one :refund, through: :charge, source: :refund
  has_one :reversal, class_name: 'Reversal', foreign_key: :transaction_id

  # Validations
  validates :amount, numericality: { greater_than_or_equal_to: 0.0 }

end
