class PurchaseMailer < ApplicationMailer
  def purchase_email(user, purchase)
    @user = user
    @purchase = purchase
    mail(to: 'haveitall@gmail.com', subject: 'Thank you for your purchase!')
  end
end
