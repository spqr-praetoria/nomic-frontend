# frozen_string_literal: true

class AddTicker < ActiveRecord::Migration[7.0]
  def change
    create_table :tickers do |t|
      t.string    :currency, null: false
      t.string    :fiat, null: false, default: 'USD'
      t.string    :name
      # put as a string, not sure how big these numbers will go.
      t.string    :circulating_supply, default: '0'
      t.string    :max_supply, default: '0'
      t.decimal   :price, default: 0.0
      t.string    :status, default: 'active'
      t.timestamp :last_fetch_at

      t.timestamps
    end

    add_index :tickers, [:currency, :fiat], unique: true
  end
end
