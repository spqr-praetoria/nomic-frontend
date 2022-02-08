# frozen_string_literal: true

module Tickers
  # Encapsulated logic for updating ticker information
  # This is so all business logic can be added in one place
  # And we don't miss things going forward, eg: we could be firing off to DataDog
  # To record how many updates we are doing over the course of months
  class Updater
    def process
      update_ticker
    end

    private

    attr_reader :object,
                :ticker_params

    def update_ticker
      object.update(ticker_params.merge!('last_fetch_at' => Time.now.utc))
    end

    def initialize(object, ticker_params = {})
      @object = object
      @ticker_params = ticker_params
    end
  end
end
