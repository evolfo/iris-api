class AdminMailer < ApplicationMailer
  def admin_email(user, purchase)
    @user = user
    @purchase = purchase
    mail(to: 'haveitall@gmail.com', subject: @user.first_name + " Purchased a " + @purchase.bundle_name)
  end
end
