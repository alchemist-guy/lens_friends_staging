class BulkShopperMailer < ApplicationMailer
  def send_email_to_shopper(email, subject, body)
    @body = body
    mail(to: email, subject: subject)
  end
end