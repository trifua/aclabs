class CurrenciesController < ApplicationController
  before_action :authorize
  before_action :set_currency, only: [:open_modal, :buy, :show, :edit, :update, :destroy]

  # GET /currencies
  # GET /currencies.json
  def index
    @currencies = Currency.where.not(default: true)
  end

  # GET /currencies/1
  # GET /currencies/1.json
  def show
  end

  # GET /currencies/new
  def new
    @currency = Currency.new
  end

  # GET /currencies/1/edit
  def edit
  end

  # POST /currencies
  # POST /currencies.json
  def create
    @currency = Currency.new(currency_params)

    respond_to do |format|
      if @currency.save
        format.html { redirect_to @currency, notice: 'Currency was successfully created.' }
        format.json { render :show, status: :created, location: @currency }
      else
        format.html { render :new }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /currencies/1
  # PATCH/PUT /currencies/1.json
  def update
    respond_to do |format|
      if @currency.update(currency_params)
        format.html { redirect_to @currency, notice: 'Currency was successfully updated.' }
        format.json { render :show, status: :ok, location: @currency }
      else
        format.html { render :edit }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /currencies/1
  # DELETE /currencies/1.json
  def destroy
    @currency.destroy
    respond_to do |format|
      format.html { redirect_to currencies_url, notice: 'Currency was successfully destroyed.' }
      format.json { head :no_content }
    end
  end




  def buy
    amount = params[:amount]

    buyer_currency = params[:buyer_currency]
    quantity_bought = params[:quantity]
    paid_amount = params[:paid]



    bought_entry = Amount.find_by(currency_id: @currency.id, user_id: current_user.id)
    if bought_entry.nil?
        Amount.create(currency_id: @currency.id, quantity: quantity_bought, user_id: current_user.id)
    else
        current_quantity =  bought_entry.quantity
        bought_entry.update_attributes(quantity: current_quantity.to_f + quantity_bought.to_f)
    end

    Transaction.create(user_id: current_user.id, original_currency_id: buyer_currency,
        original_currency_amount: paid_amount, final_currency_id: @currency.id, final_currency_amount: quantity_bought.to_f * paid_amount.to_f)


    paid_entry = Amount.find_by(currency_id: buyer_currency, user_id: current_user.id)
    if paid_entry.nil?
    else
        current_quantity = paid_entry.quantity
        new_quantity = current_quantity.to_f - paid_amount.to_f;
        if new_quantity == 0
            paid_entry.destroy
        else
            paid_entry.update_attributes(quantity: new_quantity)
        end
    end
    

    redirect_to currencies_path, notice: 'Successfully bought coins'
  end


  def open_modal
    #@currencies = params[:currency_id]
    @amount = params[:quantity].to_i

    render :partial => 'render_modal'
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_currency
      @currency = Currency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def currency_params
      params.require(:currency).permit(:name, :symbol, :default)
    end
end
