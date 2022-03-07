class Transaction < ApplicationRecord

  # Constants
  STATUSES = { approved: 1, reversed: 2, refunded: 3, error: 4 }.freeze

  # Enums
  enum status: STATUSES

  # Associations
  belongs_to :merchant

  # Validations
  validates :uuid, :customer_email, :status, :type, presence: true
  validates :uuid, uniqueness: true, allow_blank: true
  # Use validations for: uuid, amount > 0, customer_email, status
  validate :check_if_active_merchant

  # Callbacks
  before_validation :set_uuid, unless: Proc.new { |transaction| transaction.uuid.present? }

  private

  # No transactions can be submitted unless the merchant is in active state
  def check_if_active_merchant
    ActiveModel::Errors.new(self).add(:base, :blank, message: I18n.t(:cannot_be_created, scope: :transaction)) unless merchant && merchant.active?
  end

  def set_uuid
    loop do
      self.uuid = SecureRandom.random_number(36**10).to_s(36).rjust(10, '0').upcase
      break if Transaction.find_by(uuid: uuid).nil?
    end
  end

end
