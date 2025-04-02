class AdminController < ApplicationController
  before_action :authenticate_admin!, only: [:update_meal_charge,:set_custom_and_meal_time, :update_meal_timings]
  def login
    if request.post?
      if params[:username]=="admin" && params[:password]=="123456"
        flash[:notice]="login successfully"
        session[:admin]="admin"
        redirect_to home_index_url
      else
        render :action=>"login"
        flash[:notice]="Invalid username/password.Try again"
      end
    end
  end
  
  
  def logout
    
    session[:admin]=nil
    flash[:notice]="You are logged out"
    redirect_to root_url
    
  end
  
  def update_meal_charge
    setting = Setting.find_or_create_by(key: 'charge_per_meal')
    setting.update(value: params[:charge_per_meal])
    redirect_to home_index_url
    flash[:notice]="Meal charge updated successfully!"
  end



  def set_custom_and_meal_time
    @meal_timings = MealTimingSetting.all
  end

  def update_meal_timings
    if params[:meal_timing_settings].present?
      params[:meal_timing_settings].each do |key, value|

        next if value.blank? # Skip if the value is blank

        setting = MealTimingSetting.find_or_create_by(key: key)
        setting.update(value: value)
      end
      flash[:notice] = "Meal timings updated successfully!"
    else
      flash[:alert] = "No meal timings were provided."
    end

    redirect_to home_index_path
  end



  private
def authenticate_admin!
  unless session[:admin]                          #&& Admin.exists?(session[:admin])
    redirect_to admin_login_path, alert: "Access denied! Please log in."
  end
end



  
  end
