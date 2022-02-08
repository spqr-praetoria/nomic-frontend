# frozen_string_literal: true

module NomicsApiHelper
  def nomics_api_client
    @nomics_api_client ||= Nomics::Client.new do |config|
      config.api_key = ENV.fetch('NOMICS_API_KEY')
      config.base_url = ENV.fetch('NOMICS_BASE_URL')
    end
  end
end
