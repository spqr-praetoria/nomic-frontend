# frozen_string_literal: true

Rails.application.routes.draw do
  draw :marketing_routes
  root 'tickers#index'
end
