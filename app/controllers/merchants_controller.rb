class MerchantsController < ApplicationController

  before_action :load_merchants, only: [:index]
  before_action :find_merchant_by_id, only: [:destroy]

  def index; end

  def load_merchants
    @merchants = Merchant.all
  end

  def destroy
    if @merchant.destroy
      redirect_to merchants_path, info: 'Merchant Deleted'
    else
      redirect_to merchants_path, danger: 'Merchant has occured'
    end
  end

  private def find_merchant_by_id
    @merchant = Merchant.find_by(id: params[:id])
    if @merchant.nil?
      redirect_to merchants_path, danger: 'Merchant not found'
    end
  end

end
