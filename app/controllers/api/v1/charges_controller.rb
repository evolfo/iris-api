class Api::V1::ChargesController < ApplicationController
	Stripe.api_key = ENV['STRIPE_SECRET_LIVE_KEY']
	# Stripe.api_key = ENV['STRIPE_SECRET_KEY']

	def create
	  @amount = params[:amount]

	  begin
	    @amount = Float(@amount).round(2)
	  rescue
	    flash[:error] = 'Charge not completed. Please enter a valid amount in USD ($).'
	    return
	  end

	  user = User.find(params[:user_id])
	  @amount = (@amount).to_i # Must be an integer!

	  # Create a Customer if the user doesn't have a stripe_id already:
	  if !user.stripe_id
	    customer = Stripe::Customer.create({
	      source: params[:stripeToken],
	      email: params[:email]
        })

        Stripe::Charge.create({
	      amount: @amount,
	      currency: 'usd',
	      description: 'Purchase',
	      customer: customer.id
	    })

	    user.update(stripe_id: customer.id)
	    if user.save
          render json: user, status: :accepted
      	else
          render json: { errors: user.errors.full_messages }, status: :unprocessible_entity
      	end
	  else 
	  	Stripe::Charge.create({
	      amount: @amount,
	      currency: 'usd',
	      description: 'Purchase from the Lunetribe',
	      customer: user.stripe_id
	    })
      end

	  rescue Stripe::CardError => e
	    flash[:error] = e.message
	    redirect_to new_charge_path
	  end
end

