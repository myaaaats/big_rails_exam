class ContactMailer < ApplicationMailer
  def contact_mail(tweet)
    @tweet = tweet

    mail to: "maya_sato@diveintocode.jp", subject: "お問い合わせの確認メール"
  end
end
