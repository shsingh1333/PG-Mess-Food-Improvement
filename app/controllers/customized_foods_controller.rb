class CustomizedFoodsController < ApplicationController
  before_action :authenticate_admin! 
  before_action :set_customized_food, only: %i[ show edit update destroy ]

  # GET /customized_foods or /customized_foods.json
  def index
    @customized_foods = CustomizedFood.all
  end

  # GET /customized_foods/1 or /customized_foods/1.json
  def show
  end

  # GET /customized_foods/new
  def new
    @customized_food = CustomizedFood.new
  end

  # GET /customized_foods/1/edit
  def edit
  end

  # POST /customized_foods or /customized_foods.json
  def create
    @customized_food = CustomizedFood.new(customized_food_params)

    respond_to do |format|
      if @customized_food.save
        format.html { redirect_to @customized_food, notice: "Customized food was successfully created." }
        format.json { render :show, status: :created, location: @customized_food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customized_food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customized_foods/1 or /customized_foods/1.json
  def update
    respond_to do |format|
      if @customized_food.update(customized_food_params)
        format.html { redirect_to @customized_food, notice: "Customized food was successfully updated." }
        format.json { render :show, status: :ok, location: @customized_food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @customized_food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customized_foods/1 or /customized_foods/1.json
  def destroy
    @customized_food.destroy!

    respond_to do |format|
      format.html { redirect_to customized_foods_path, status: :see_other, notice: "Customized food was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customized_food
      @customized_food = CustomizedFood.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def customized_food_params
      params.expect(customized_food: [ :name, :price, :description ,:food_image])
    end






    private
    def authenticate_admin!
      unless session[:admin]                          #&& Admin.exists?(session[:admin])
        redirect_to admin_login_path, alert: "Access denied! Please log in."
      end
    end


end
