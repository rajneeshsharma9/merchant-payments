require 'rails_helper'

describe Transaction do

  let(:transaction) { create(:transaction) }

  describe 'Constants' do
    it { expect(Transaction::STATUSES).to eq({ approved: 1, reversed: 2, refunded: 3, error: 4 }) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:merchant) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:customer_email) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:type) }
  end

  describe 'Instance Methods' do
    describe '#set_uuid' do
      context 'when uuid is not present' do
        before do
          transaction.uuid = nil
          transaction.send(:set_uuid)
        end
        it 'it sets uuid to unique value' do
          expect(transaction.uuid).not_to eq('')
        end
      end
    end
  end

end
