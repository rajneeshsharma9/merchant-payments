# Can be done using auth gem along with roles and permissions gem but not part of scope
class Merchant < ApplicationRecord

  # Associations
  has_many :transactions, dependent: :restrict_with_error
  # Ensure you prevent a merchant from being deleted unless there are no related payment transactions
  has_many :authorize_transactions, class_name: 'AuthorizeTransaction', inverse_of: :merchant
  has_many :charges, class_name: 'Charge', inverse_of: :merchant
  has_many :refunds, class_name: 'Refund', inverse_of: :merchant
  has_many :reversals, class_name: 'Reversal', inverse_of: :merchant

  # Validations
  validates :name, :email, presence: true
  validates :name, :email, uniqueness: true, allow_blank: true
  validates :total_transaction_sum, numericality: { greater_than_or_equal_to: 0.0 }


  def recalculate_transaction_sum
    update(total_transaction_sum: charges.approved.sum(&:amount))
  end

end
