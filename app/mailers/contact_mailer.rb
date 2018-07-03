class ContactMailer < ApplicationMailer
  def contact_mail(current_user_email,tweet)
    @tweet = tweet

    mail to: current_user_email, subject: "お問い合わせの確認メール"
  end
end
