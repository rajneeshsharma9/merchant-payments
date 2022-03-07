require 'rails_helper'

RSpec.describe "API Transactions Spec", type: :request do

  let(:merchant) { create(:merchant) }

   describe "POST /create" do
    context 'when Basic Authentication is not passed' do
      before do
        post "/transactions"
      end

      it 'returns unauthorized response status' do
        expect(response.status).to eq(401)
      end
    end

    context 'when Basic Authentication is passed' do
      context 'when merchant is not present' do
        before do
          user = '1username'
          pw = 'password1'
          post "/transactions", headers: { HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials(user,pw) }
        end

        it 'returns unauthorized response status' do
          expect(response.status).to eq(404)
        end
      end
    end
  end

end
