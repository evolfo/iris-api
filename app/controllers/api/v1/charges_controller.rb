class Api::V1::ChargesController < ApplicationController
	Stripe.api_key = ENV['STRIPE_SECRET_LIVE_KEY']
	# Stripe.api_key = 'sk_test_jHV82ZbgjYBCtRwb7azV2QG900mpb4Af3v'

	def create
	  @amount = params[:amount]

	  begin
	    @amount = Float(@amount).round(2)
	  rescue
	    flash[:error] = 'Charge not completed. Please enter a valid amount in USD ($).'
	    return
	  end

	  user = User.find(params[:user_id])
	  purchase = user.purchases.last
	  @amount = (@amount).to_i # Must be an integer!

	  # Create a Customer if the user doesn't have a stripe_id already:
	  if !user.stripe_id
	    customer = Stripe::Customer.create({
	      source: params[:stripeToken],
	      email: params[:email]
        })

        charge = Stripe::Charge.create({
	      amount: @amount,
	      currency: 'usd',
	      description: params[:bundle_name],
	      customer: customer.id
		})
		
		user.update(stripe_id: customer.id)
	  else 
	  	charge = Stripe::Charge.create({
	      amount: @amount,
	      currency: 'usd',
	      description: params[:bundle_name],
	      customer: user.stripe_id
	    })
	  end

	  purchase.update(order_id: charge.id)
	    if purchase.save || user.save
          render json: {
			  user: user,
			  purchase: purchase
		  }

		  # Authenticate a session with your Service Account
		  session = GoogleDrive::Session.from_service_account_key("Iris Lune Funnel-fcb321a99064.json")

		  # Get the spreadsheet by its title
		  spreadsheet = session.spreadsheet_by_title("Iris Lune Merch + Funnel")
		  # Get the first worksheet
		  worksheet = spreadsheet.worksheets.first
		
		  # updating the spreadsheet on google drive, each element of the array is a block in the spreadsheet
		  worksheet.insert_rows(worksheet.num_rows + 1, [[Time.now.strftime('%F'), purchase.user.full_name, purchase.user.email, "#{purchase.user.billing_address}, #{purchase.user.zip_code}", purchase.bundle_name, "n"]])
		  worksheet.save

		  PurchaseMailer.purchase_email(purchase).deliver_now
      	  AdminMailer.admin_email(purchase).deliver_now
      	else
          render json: { errors: user.errors.full_messages }, status: :unprocessible_entity
		end

	  rescue Stripe::CardError => e
	    flash[:error] = e.message
	    redirect_to new_charge_path
	  end
end

