class TransactionsController < ApplicationController

  before_action :http_basic_authenticate, only: [:create]
  before_action :find_merchant_by_email, only: [:create]
  before_action :load_transactions, only: [:index]

  # Accepts payments using XML/ JSON API (single point POST request)
  def create
    @transaction = @merchant.build_transaction(transaction_params)
    if @transaction.save
      render json: @transaction.to_json, status: 200
    else
      render json: { error: true, message: I18n.t(:cannot_be_created, scope: :transaction) }, status: 422
    end
  end

  def index; end

  private

  def http_basic_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "1username" && password == "password1"
    end
  end

  def find_merchant_by_email
    @merchant = Merchant.find_by(email: params[:merchant][:email]) if params[:merchant]
    if @merchant.nil?
      respond_to do |format|
        format.json { render json: { error: true }, status: 404 }
      end
    end
  end

  def transaction_params
    params.require(:store).permit([:customer_email, :customer_phone, :status, :amount, :type])
  end

  def load_transactions
    @transactions = Transaction.all
  end

end
