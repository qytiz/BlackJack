# frozen_string_literal: true

require_relative 'deck'
class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def get_card(deckcard)
    @cards << deckcard
  end

  def too_much?
    @cards.length == 2
  end

  def count_cards
    cards_value = 0
    a = @cards.filter { |card| card.value == 'A' }.length

    @cards.each do |card|
      cards_value += if card.value =~ /[J,Q,K]/
                       10
                     else
                       if card.value == 'A'
                         11
                       else
                         card.value
                       end
                     end
    end
    i = 0
    while i < @cards.filter { |card| card.value == 'A' }.length && cards_value > 21
      i += 1
      cards_value -= 10
    end
    cards_value
  end
end
