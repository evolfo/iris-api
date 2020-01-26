class PurchaseMailer < ApplicationMailer
  def purchase_email(purchase)
    @purchase = purchase
    @user = purchase.user
    mail(to: @user.email, subject: 'Thank you for your purchase!')
  end
end
