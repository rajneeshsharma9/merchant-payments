require 'rails_helper'

describe Charge do

  let(:charge) { create(:charge) }

  describe 'Associations' do
    it { is_expected.to belong_to(:authorized_transaction).class_name(AuthorizeTransaction).with_foreign_key(:transaction_id) }
  end

  describe 'Validations' do
    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0.0) }
  end

end
