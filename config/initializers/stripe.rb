# Rails.configuration.stripe = {
#   :publishable_key => Rails.application.credentials.stripe[:publishable_key],
#   :secret_key      => Rails.application.credentials.stripe[:secret_key]
# }
# Stripe.api_key = Rails.configuration.stripe[:secret_key]

Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_PUBLISHABLE_LIVE_KEY'],
  :secret_key      => ENV['STRIPE_SECRET_LIVE_KEY']
}
Stripe.api_key = ENV['STRIPE_SECRET_LIVE_KEY']
