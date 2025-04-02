class AddStudentMailer < ApplicationMailer
    
    def student_added_email(student)
        @student = student
        mail(
          to: @student.email,
          subject: "Welcome to PG Mess System!"
        )
      end

      def student_updated_email(student)
        @student = student
        mail(
          to: @student.email,
          subject: "Welcome to PG Mess System!"
        )
      end 
      
end
