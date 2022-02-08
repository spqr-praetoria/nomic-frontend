# frozen_string_literal: true

class TickerDecorator < Draper::Decorator
  delegate_all

  def display_conversion
    h.content_tag(:p, "1#{object.currency} = #{1.0 * object.price.round(2)} #{object.fiat}")
  end
end
