class AdminMailer < ApplicationMailer
  def admin_email(purchase)
    @purchase = purchase
    @user = purchase.user
    mail(to: 'management@irislune.com', subject: @user.first_name + " Purchased a " + @purchase.bundle_name)
  end
end
