require 'rails_helper'

describe Merchant do

  let(:merchant) { create(:merchant) }

  describe 'Associations' do
    it { is_expected.to have_many(:transactions).dependent(:restrict_with_error) }
    it { is_expected.to have_many(:authorize_transactions).class_name('AuthorizeTransaction').inverse_of(:merchant) }
    it { is_expected.to have_many(:charges).class_name('Charge').inverse_of(:merchant) }
    it { is_expected.to have_many(:refunds).class_name('Refund').inverse_of(:merchant) }
    it { is_expected.to have_many(:reversals).class_name('Reversal').inverse_of(:merchant) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_numericality_of(:total_transaction_sum) }
  end

  describe 'Instance Methods' do
    describe '#recalculate_transaction_sum' do
      context 'when charges are not present' do
        before do
          merchant.charges = []
          merchant.total_transaction_sum = 100.0
          merchant.recalculate_transaction_sum
        end

        it 'should set total_transaction_sum to zero' do
          expect(merchant.total_transaction_sum).to eq(0.0)
        end
      end
    end
  end

end
