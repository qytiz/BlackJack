# frozen_string_literal: true

require_relative 'deck'
class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def get_card(deck)
    @cards << deck.take_card
  end

  def too_much?
    @cards.length == 2
  end

  def count_cards
    cards_value = 0
    a = 0
    @cards.each do |card|
      if card.value != 11
        cards_value += card.value
      else
        a += 1
      end
    end
    a.times do
      cards_value += if cards_value + 11 > 21
                       1
                     else
                       if 21 - (cards_value + 1) < 21 - (cards_value + 11)
                         1
                       else
                         11
                       end
                     end
    end
    cards_value
  end
end
