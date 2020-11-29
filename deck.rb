# frozen_string_literal: true

require_relative 'card'
class Deck
  attr_reader :deck

  SUIT = '+,<3,^,<>'.split(',')
  VALUES = '2,3,4,5,6,7,8,9,10,J,Q,K,A'.split(',')

  def initialize
    @deck = []
    generate
    shuffle
  end

  def generate
    VALUES.product(SUIT) { |el| @deck << Card.new(el) }
  end

  def shuffle
    @deck.shuffle!
  end

  def take_card
    @deck.delete_at(0)
  end
end
