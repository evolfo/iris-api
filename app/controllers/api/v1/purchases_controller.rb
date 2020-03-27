class Api::V1::PurchasesController < ApplicationController
  before_action :authenticate, only: [:index]
  before_action :find_purchase, only: [:update]

  def index
    @purchases = Purchase.all
    render json: @purchases
  end

  def create
    @purchase = Purchase.create(purchase_params)
    
  	if @purchase.valid?
  	  render json: { purchase: PurchaseSerializer.new(@purchase) }, status: :created
      # update_spreadsheet(@purchase)
  	else
  	  render json: { errors: @purchase.errors.full_messages }, status: :unprocessible_entity
  	end
  end
 
  def update
    @purchase.update(purchase_params)
    if @purchase.save
      render json: @purchase, status: :accepted
    else
      render json: { errors: @purchase.errors.full_messages }, status: :unprocessible_entity
    end
  end
 
  private
 
  def purchase_params
    params.permit(:amount, :bundle_name, :user_id, :order_id)
  end
 
  def find_purchase
    @purchase = Purchase.find(params[:id])
  end
end
