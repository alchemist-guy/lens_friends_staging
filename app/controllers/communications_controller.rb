  class CommunicationsController < ApplicationController
    before_action :authenticate_user!

    def book_request
      seller = User.find_by(id: params[:seller_id])
      CommunicationMailer.book_request_email(seller, current_user).deliver_now
      send_email(seller.email, current_user.email)
    end

    # def send_email(receiver_email, sender_email)
    #   email_subject = 'LensFriends Match!'
    #   email_body = "Hello!


    #   I recently discovered your profile on LensFriends and was truly impressed by your portfolio. Your work reflects a style and creativity that aligns with what I have envisioned for my upcoming event. 
      
      
    #   I am reaching out to explore the possibility of collaborating with you. I would love to discuss how we can work together. 
      
      
    #   Looking forward to hearing from you!
      
      
    #   [YOUR NAME]
    #   "

    #   subject_param = CGI.escape(email_subject)
    #   body_param = CGI.escape(email_body)
  
    #   mailto_link = "mailto:#{receiver_email}?subject=#{subject_param}&body=#{body_param}&from=#{sender_email}"

    #   redirect_to mailto_link, allow_other_host: true
    # end


    def send_email(receiver_email, sender_email)
      email_subject = 'LensFriends Match!'
      email_body = <<~BODY
        Hello!
    
        I recently discovered your profile on LensFriends and was truly impressed by your portfolio. Your work reflects a style and creativity that aligns with what I have envisioned for my upcoming event.
    
        I am reaching out to explore the possibility of collaborating with you. I would love to discuss how we can work together.
    
        Looking forward to hearing from you!
    
        [YOUR NAME]
      BODY
    
      subject_param = CGI.escape(email_subject).gsub('+', '%20')
      body_param = CGI.escape(email_body).gsub('+', '%20')
    
      mailto_link = "mailto:#{receiver_email}?subject=#{subject_param}&body=#{body_param}&from=#{sender_email}"
    
      redirect_to mailto_link, allow_other_host: true
    end

  end