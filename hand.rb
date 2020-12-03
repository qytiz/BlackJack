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
    @cards.filter { |card| card.value == 'A' }.each do
      cards_value -= 10 if cards_value > 21
    end
    cards_value
  end
end
