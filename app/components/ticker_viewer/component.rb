# frozen_string_literal: true

module TickerViewer
  class Component < ViewComponent::Base
    attr_reader :ticker

    def initialize(ticker:)
      super
      @ticker = ticker
    end
  end
end
