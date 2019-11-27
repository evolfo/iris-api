class LunetribeMailer < ApplicationMailer
    def lunetribe_email(user)
        @user = user
        mail(to: 'management@irislune.com', subject: @user.first_name + " Opted in to the Lunetribe")
        mail(to: @user.email, subject: 'Welcome to the Lunetribe!')
    end
end
