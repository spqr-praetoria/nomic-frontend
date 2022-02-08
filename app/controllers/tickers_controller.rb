# frozen_string_literal: true

class TickersController < ApplicationController
  layout 'marketing'

  before_action :set_ticker, only: [:show, :destroy]

  def index
    @tickers = Ticker.all
  end

  def show; end

  def new
    @ticker = Ticker.new
  end

  def create
    @ticker = Ticker.new(ticker_params)

    if @ticker.save
      render turbo_stream: turbo_stream.replace('tickers', partial: 'index', locals: { tickers: Ticker.all })
    else
      render turbo_stream: turbo_stream.replace('new_ticker', partial: 'form', locals: { ticker: @ticker })
    end
  end

  def destroy
    @ticker.destroy

    render turbo_stream: turbo_stream.replace('tickers', partial: 'index', locals: { tickers: Ticker.all })
  end

  private

  def set_ticker
    @ticker = Ticker.find(params[:id])
  end

  def ticker_params
    params.required(:ticker).permit(:currency, :fiat)
  end
end
