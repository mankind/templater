class CustomerMailersController < ApplicationController
  before_action :set_customer_mailer, only: [:show, :edit, :update, :destroy]

  # GET /customer_mailers
  # GET /customer_mailers.json
  def index
    @customer_mailers = CustomerMailer.all
  end

  # GET /customer_mailers/1
  # GET /customer_mailers/1.json
  def show
  end

  # GET /customer_mailers/new
  def new
    @customer_mailer = CustomerMailer.new
  end

  # GET /customer_mailers/1/edit
  def edit
  end

  # POST /customer_mailers
  # POST /customer_mailers.json
  def create
    @customer_mailer = CustomerMailer.new(customer_mailer_params)

    respond_to do |format|
      if @customer_mailer.save
        #deliver the email
        #CustomerMail.liquid_database_template(@customer_mailer).deliver
        CustomerMail.welcome(@customer_mailer).deliver
        format.html { redirect_to @customer_mailer, notice: 'Customer mailer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @customer_mailer }
      else
        format.html { render action: 'new' }
        format.json { render json: @customer_mailer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_mailers/1
  # PATCH/PUT /customer_mailers/1.json
  def update
    respond_to do |format|
      if @customer_mailer.update(customer_mailer_params)
        CustomerMail.welcome(@customer_mailer).deliver
        format.html { redirect_to @customer_mailer, notice: 'Customer mailer was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @customer_mailer }
      else
        format.html { render action: 'edit' }
        format.json { render json: @customer_mailer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_mailers/1
  # DELETE /customer_mailers/1.json
  def destroy
    @customer_mailer.destroy
    respond_to do |format|
      format.html { redirect_to customer_mailers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_mailer
      @customer_mailer = CustomerMailer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_mailer_params
      params.require(:customer_mailer).permit(:name, :email)
    end
end
