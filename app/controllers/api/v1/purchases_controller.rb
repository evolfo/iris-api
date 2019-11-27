class Api::V1::PurchasesController < ApplicationController

  before_action :find_purchase, only: [:update]

  def index
    @purchases = Purchase.all
    render json: @purchases
  end

  def create
    @purchase = Purchase.create(purchase_params)
    
  	if @purchase.valid?
  	  render json: { purchase: PurchaseSerializer.new(@purchase) }, status: :created
      PurchaseMailer.purchase_email(@purchase.user, @purchase).deliver_now
      AdminMailer.admin_email(@purchase.user, @purchase).deliver_now

      update_spreadsheet(@purchase)
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

  def update_spreadsheet(purchase)
    # Authenticate a session with your Service Account
      session = GoogleDrive::Session.from_service_account_key("Iris Lune Funnel-fcb321a99064.json")

      # Get the spreadsheet by its title
      spreadsheet = session.spreadsheet_by_title("Iris Lune Merch + Funnel")
      # Get the first worksheet
      worksheet = spreadsheet.worksheets.first
      
      # updating the spreadsheet on google drive, each element of the array is a block in the spreadsheet
      worksheet.insert_rows(worksheet.num_rows + 1, [[Time.now.strftime('%F'), purchase.user.full_name, purchase.user.billing_address + ", " + purchase.user.zip_code, purchase.bundle_name]])
      worksheet.save
  end
 
  def purchase_params
    params.permit(:amount, :bundle_name, :user_id)
  end
 
  def find_purchase
    @purchase = Purchase.find(params[:id])
  end
end
