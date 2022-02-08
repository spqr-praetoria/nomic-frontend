# frozen_string_literal: true

module Tickers
  # This fetcher returns the entire response from the
  class CurrencyFetcher
    include NomicsApiHelper

    attr_accessor :response,
                  :success

    attr_reader :object,
                :options

    def process
      gather_currency_information
      response
    end

    def success?
      success
    end

    private

    def initialize(object, options = {})
      @object = object
      @options = options
      @success = false
    end

    def gather_currency_information
      @response = client.currencies_ticker(query_params)[:data][0].slice(
        'currency',
        'name',
        'status',
        'circulating_supply',
        'max_supply',
        'price',
        'status'
      )

      @success = true
    rescue StandardError
      @success = false
    end

    def query_params
      { ids: object.currency, convert: object.fiat }.merge(options)
    end

    def client
      @client ||= nomics_api_client
    end
  end
end
