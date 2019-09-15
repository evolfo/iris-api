class PurchaseMailer < ApplicationMailer
  def purchase_email(user, purchase)
    @user = user
    @purchase = purchase
    mail(to: @user.email, subject: 'Thank you for your purchase!')
  end
end
