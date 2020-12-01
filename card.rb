# frozen_string_literal: true

class Card
  attr_reader :value, :suit

  def initialize(suit, value)
    @suit = suit
    @value = value
  end
end
