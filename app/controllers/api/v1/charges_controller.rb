class Api::V1::ChargesController < ApplicationController

    Stripe.api_key = ENV['STRIPE_S_KEY']

	def create
	  @amount = params[:amount]

	  begin
	    @amount = Float(@amount).round(2)
	  rescue
	    # flash[:error] = 'Charge not completed. Please enter a valid amount in USD ($).'
	    return
	  end

	  @amount = (@amount).to_i # Must be an integer!

	  byebug

	  Stripe::Charge.create({
	    amount: @amount,
	    currency: 'usd',
	    source: params[:stripeToken],
	    description: 'Purchase',
	  })

	  rescue Stripe::CardError => e
	    flash[:error] = e.message
	    redirect_to new_charge_path
	  end
end

