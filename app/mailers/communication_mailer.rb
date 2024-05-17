class CommunicationMailer < ApplicationMailer
  def book_request_email(seller, current_user)
    @seller = seller
    @current_user = current_user

    mail(to: @seller.email, subject: 'Profile Viewed on LensFriends by Client')
  end
end
