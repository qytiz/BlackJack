# frozen_string_literal: true

require_relative 'card'
class Deck
  attr_reader :deck

  def initialize
    @deck = []
    '2,3,4,5,6,7,8,9,10,J,Q,K,A'.split(',').product('+,<3,^,<>'.split(',')) { |el| @deck << Card.new(el) }
    shuffle
  end

  def shuffle
    @deck.sort_by! { rand }
  end

  def take_card
    @deck.delete_at(0)
  end
end
