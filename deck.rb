# frozen_string_literal: true

require_relative 'card'
class Deck
  attr_reader :deck

  SUITS = ['+', '<3', '^', '<>'].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze

  def initialize
    @deck = []
    generate
    shuffle
  end

  def generate
    SUITS.each do |suit|
      VALUES.each { |value| @deck << Card.new(suit, value) }
    end
  end

  def shuffle
    @deck.shuffle!
  end

  def take_card
    @deck.delete_at(0)
  end
end
