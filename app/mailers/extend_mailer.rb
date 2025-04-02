class ExtendMailer < ApplicationMailer
    def one_meal_extended(receipt)
         @receipt = receipt
    @student = receipt.student
    @total_meals = receipt.total_meal
    @remaining_meals = receipt.remaining_meal
    mail(
          to: @student.email,
          subject: "Meal Extended!"
        )
      end 


      def send_extend_email(current_user, recipient_email)
        @user = current_user  # The logged-in user
        mail(to: recipient_email, subject: "Meal Extension Notification from #{@user.email}")
      end
end
