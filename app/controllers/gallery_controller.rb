class GalleryController < ApplicationController
  before_action :authenticate_admin! , only:[:setting_meal_charge]
    def index
        @food_gallery=CustomizedFood.all
      end
    

  def checkout
    amount_to_charge = session[:amount].to_i
    if request.post?
      ActiveMerchant::Billing::Base.mode = :test
      # ActiveMerchant accepts all amounts as Integer values in cents
      credit_card = ActiveMerchant::Billing::CreditCard.new(
      :first_name         => params[:first_name],
      :last_name          => params[:last_name],
      :number             => params[:credit_no].to_s,
      :month              => params[:check][:month].to_s,
      :year               => params[:check][:year].to_s,
      :verification_value => params[:verification_number].to_s)
  
      # Validating the card automatically detects the card type
      gateway =ActiveMerchant::Billing::TrustCommerceGateway.new(
      :login => 'TestMerchant',
      :password =>'password',
      :test => 'true' )
  
      response = gateway.authorize(amount_to_charge , credit_card)
      #response = gateway.purchase(amount_to_charge, credit_card)
      puts response.inspect
        if response.success?
          gateway.capture(amount_to_charge, response.authorization)
            
          @cart = Cart.find(session[:cart_id]) if session[:cart_id].present?

          @line_items = @cart.line_items.includes(:customized_food) # Fetch associated customized food
          recipient_email = "shivam.singh@bitlasoft.com" 
          @student = Student.includes(:receipt).find_by(email: current_user.email)
          PaymentMailer.send_payment_info_email(current_user, recipient_email,@student, @line_items).deliver_now
          #UserNotifier.purchase_complete(session[:user],current_cart).deliver
          #flash[:notice]="Thank You for using Pink Flowers. The oreder details are sent to your mail"
          session[:cart_id]=nil
          session[:amount]=nil
          redirect_to :action=>:purchase_complete
        else
          flash[:notice]= "Something went wrong.Try again"
          render :action => "checkout",status: :unprocessable_entity
        end
      end

      
  end








  private
  def authenticate_admin!
    unless session[:admin]                          #&& Admin.exists?(session[:admin])
      redirect_to admin_login_path, alert: "Access denied! Please log in."
    end
  end
  
  
end
