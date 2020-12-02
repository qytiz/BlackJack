# frozen_string_literal: true

require_relative 'card'
class Deck
  attr_reader :deck


  def initialize
    @deck = []
    generate
    shuffle
  end

  def generate
    Card::SUITS.each do |suit|
      Card::VALUES.each { |value| @deck << Card.new(suit, value) }
    end
  end

  def shuffle
    @deck.shuffle!
  end

  def take_card
    @deck.delete_at(0)
  end
end
