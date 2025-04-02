class ReceiptsController < ApplicationController
  before_action :authenticate_admin! , except: [:fetch_receipt , :show_receipt]
  before_action :set_receipt, only: %i[ show edit update destroy ]



  def extend_meal
    @receipt = Receipt.find(params[:id])
    if @receipt.remaining_meal < @receipt.total_meal
    @receipt.increment!(:remaining_meal) # Increases by 1
    ExtendMailer.one_meal_extended(@receipt).deliver_now
    redirect_to receipts_path, notice: "Meal extended successfully!"
    else
      redirect_to receipts_path, alert: "Cannot extend beyond total meals."
    end
  end






  # GET /receipts or /receipts.json
  def index
    @receipts = Receipt.all
  end

  # GET /receipts/1 or /receipts/1.json
  def show
  end

  # GET /receipts/new
  def new
    @receipt = Receipt.new
  end

  # GET /receipts/1/edit
  def edit
  end

  # POST /receipts or /receipts.json
  def create
    @receipt = Receipt.new(receipt_params)

    respond_to do |format|
      if @receipt.save
        format.html { redirect_to @receipt, notice: "Receipt was successfully created." }
        format.json { render :show, status: :created, location: @receipt }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /receipts/1 or /receipts/1.json
  def update
    respond_to do |format|
      if @receipt.update(receipt_params)
        format.html { redirect_to @receipt, notice: "Receipt was successfully updated." }
        format.json { render :show, status: :ok, location: @receipt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receipts/1 or /receipts/1.json
  def destroy
    @receipt.destroy!

    respond_to do |format|
      format.html { redirect_to receipts_path, status: :see_other, notice: "Receipt was successfully destroyed." }
      format.json { head :no_content }
    end
  end




  def fetch_receipt
    # Renders the form for user input
  end
  
  def show_receipt
    email = params[:email].strip.downcase  # Normalize email input
    puts "Received email: #{email}"  # Debugging log
    if email.blank?
      flash[:alert] = "Email cannot be blank."
      redirect_to fetch_receipt_path
      return
    end

    Rails.logger.info "======================================"
    Rails.logger.info params[:email]

    student = Student.find_by(email: email)
    puts "Student found: #{student.inspect}"  # Debugging log

    Rails.logger.info "======================================"
    Rails.logger.info student

    if student
      latest_receipt = student.receipts.order(created_at: :desc).first
      puts "Latest receipt found: #{latest_receipt.inspect}"  # Debugging log
      if latest_receipt
        render :show_receipt, locals: { receipt: latest_receipt }
      else
        flash[:alert] = "No receipts found for this student."
        redirect_back fallback_location: fetch_receipt_path
      end
    else
      flash[:alert] = "Student not found."
      redirect_back fallback_location: fetch_receipt_path
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_receipt
      @receipt = Receipt.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def receipt_params
      params.expect(receipt: [ :receipt_date, :for_month, :advance, :mess,:total_meal, :remaining_meal ,:room_rent, :total, :payment_done, :student_id ])
    end



    private
    def authenticate_admin!
      unless session[:admin]                          #&& Admin.exists?(session[:admin])
        redirect_to admin_login_path, alert: "Access denied! Please log in."
      end
    end




    
end
