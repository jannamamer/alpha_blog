class StocksController < ApplicationController
  def index; end

  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      
      if @stock
        render 'stocks/index'
      else
        flash[:alert] = 'Please enter a valid symbol to search'
        redirect_to stocks_path
      end
    else
      flash[:alert] = 'Please enter a symbol to search'
      redirect_to stocks_path
    end
  end
end
