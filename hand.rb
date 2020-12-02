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
      cards_value += if card.value =~ /[J,Q,A,K]/
                       10
                     else
                       card.value
                     end
    end
    while a.positive?
      if cards_value > 21
        a -= 1
        cards_value -= 10
      else
        a = 0
      end
    end

    cards_value
  end
end
