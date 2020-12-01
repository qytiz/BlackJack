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
      if card.value =~ /[J,Q,A,K]/
        if card.value != 'A'
          cards_value += 10
        else
          cards_value += 10
          a += 1
        end
      else
        cards_value += card.value
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
