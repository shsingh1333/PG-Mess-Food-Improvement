class PaymentMailer < ApplicationMailer

    def send_payment_info_email(current_user, recipient_email, student,line_items)
        @user = current_user  # The logged-in user
         @student=student
     @line_items=line_items
    
        mail(to: recipient_email, subject: "New Order Received from #{@user.email}")
      end
end
