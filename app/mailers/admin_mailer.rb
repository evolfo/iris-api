class AdminMailer < ApplicationMailer
  def admin_email(user, purchase)
    @user = user
    @purchase = purchase
    mail(to: 'management@irislune.com', subject: @user.first_name + " Purchased a " + @purchase.bundle_name)
  end
end
