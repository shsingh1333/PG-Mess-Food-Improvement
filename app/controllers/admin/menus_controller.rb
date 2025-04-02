module Admin
    class MenusController < AdminController  # Inherit from AdminController
      # before_action :authenticate_admin!
      def index
        @menus = Menu.order(:date)
      end
  
     
     
      # private
      # def authenticate_admin!
      #   unless session[:admin]                          #&& Admin.exists?(session[:admin])
      #     redirect_to admin_login_path, alert: "Access denied! Please log in."
      #   end
      # end
  
    
     
    end
  end
  