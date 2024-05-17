class BulkSellerMailer < ApplicationMailer
  def send_email_to_seller(email, subject, body)
    @body = body
    mail(to: email, subject: subject)
  end
end