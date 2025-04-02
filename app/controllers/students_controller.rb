class StudentsController < ApplicationController
  before_action :authenticate_admin!, except: [:my_details,:extend_meal]
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index
    @students = Student.all
    @total_students = Student.count
  end

  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)


    AddStudentMailer.student_added_email(@student).deliver_now

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update


    AddStudentMailer.student_updated_email(@student).deliver_now
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy!

    respond_to do |format|
      format.html { redirect_to students_path, status: :see_other, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end




  def my_details

    @student = Student.includes(:receipt).find_by(email: current_user.email) # Eager loading receipts


    if @student
      @receipts = @student.receipt
    else
      redirect_to admin_menus_path, alert: "No student details found for your email."
    end
  end


  def extend_meal
    recipient_email = "shivam.singh@bitlasoft.com"  # Change this to your target email

    ExtendMailer.send_extend_email(current_user, recipient_email).deliver_now # Send email

    redirect_to admin_menus_path, notice: "Email sent successfully!"
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.expect(student: [ :name, :contact_no, :aadhar_card_no, :email ,:date_of_occupy, :room_no ])
    end



    private
    def authenticate_admin!
      unless session[:admin]                          #&& Admin.exists?(session[:admin])
        redirect_to admin_login_path, alert: "Access denied! Please log in."
      end
    end
end
