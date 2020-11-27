# frozen_string_literal: true

require_relative 'deck'
class Player
  attr_reader :hand, :cards_value
  attr_accessor :money

  def initialize(name)
    @hand = []
    @cards_value = 0
    @name = name
    @money = 100
  end

  def get_card(deck)
    @hand << deck.take_card
    count_cards
  end

  def count_cards
    @cards_value = 0
    a = 0
    @hand.each do |card|
      if card.value != 11
        @cards_value += card.value
      else
        a += 1
      end
    end
    a.times do
      @cards_value += if @cards_value + 11 > 21
                        1
                      else
                        if 21 - (@cards_value + 1) < 21 - (@cards_value + 11)
                          1
                        else
                          11
                        end
                      end
    end
  end
end
class AI < Player
  def turn(game)
    if @cards_value < 17 && @hand.length < 3
      game.add_card
    else
      game.skip
    end
  end
end

class Game
  attr_reader :players, :deck, :game_over

  def initialize(name)
    @player_turn = true
    @players = []
    @players << Player.new(name)
    @players << AI.new('AI')
    start_game
    @game_over = false
  end

  def start_game
    @deck = Deck.new
    @deck.shuffle

    @players[0].money -= 10
    2.times { @players[0].get_card(@deck) }

    @players[1].money -= 10
    2.times { @players[1].get_card(@deck) }
  end

  def skip
    if @player_turn
      @player_turn = false
      @players[1].turn(self)
    else
      @player_turn = true
    end
  end

  def add_card
    @players[(@player_turn ? 0 : 1)].get_card(@deck)
    if @player_turn
      @player_turn = false
      @players[1].turn(self)
    else
      @player_turn = true
    end
  end

  def open_cards
    @player_turn = true
    if @players[0].cards_value > 21 && @players[1].cards_value < 21 || @players[0].cards_value < @players[1].cards_value
      @players[1].money += 20
      res = 'Победа диллера'
    else
      if @players[0].cards_value == @players[1].cards_value || @players[0].cards_value > 21 && @players[1].cards_value > 21
        @players[0].money += 10
        @players[1].money += 10
        res = 'Ничья'
      else
        @players[0].money += 20
        res = 'Вы победили'
      end
    end
    if @players[0].money < 10

      @game_over = true
      res += ' У вас закончились деньги'
    else
      if @players[1].money < 10
        @game_over = true
        res += ' У диллера закончились деньги'
      else
        @players[0].hand.clear
        @players[1].hand.clear
        start_game
        res
      end
    end
  end
end
