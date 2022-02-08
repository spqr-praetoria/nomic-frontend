# frozen_string_literal: true

class Ticker < ApplicationRecord
  validates_uniqueness_of :currency, scope: :fiat, message: 'This currency pair already exists'
  validates_presence_of :currency, :fiat

  before_save -> { currency.upcase! && fiat.upcase! }

  after_create_commit :fetch_meta_data

  private

  # Not too happy about making a call to an external API here but for local testing purposes
  # This will not be a delayed job
  def fetch_meta_data
    return self if last_fetch_at.present? && (Time.now.utc - last_fetch_at < 1.minute)

    fetcher = Tickers::CurrencyFetcher.new(self)
    ticker_data = fetcher.process

    Tickers::Updater.new(self, ticker_data).process if fetcher.success?
  end
end
