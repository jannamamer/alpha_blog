# frozen_string_literal: true

class StocksController < ApplicationController
  def index
    @stocks = current_user.stocks
  end

  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'stocks/result' }
        end
      else
        respond_to do |format|
          flash[:alert] = 'Please enter a valid symbol to search'
          format.js { render partial: 'stocks/result' }
        end
      end
    else
      respond_to do |format|
        flash[:alert] = 'Please enter a symbol to search'
        format.js { render partial: 'stocks/result' }
      end
    end
  end
end
