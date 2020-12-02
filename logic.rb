# frozen_string_literal: true

require_relative 'hand'
require_relative 'deck'

class Player
  attr_reader :hand, :cards_value, :name
  attr_accessor :money

  def initialize(name)
    @hand = Hand.new
    @name = name
    @money = 100
  end

  def get_card(deckcard)
    @hand.get_card(deckcard)
  end
end
class AI < Player
  def turn(game)
    if @hand.count_cards < 17 && @hand.too_much?
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
    @players << AI.new('Диллер')
    start_game
    @game_over = false
  end

  def start_game
    @deck = Deck.new
    @deck.shuffle
    @player_turn = true
    @players[0].money -= 10
    2.times { @players[0].get_card(@deck.take_card) }

    @players[1].money -= 10
    2.times { @players[1].get_card(@deck.take_card) }
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
    @players[(@player_turn ? 0 : 1)].get_card(@deck.take_card)
    if @player_turn
      @player_turn = false
      @players[1].turn(self)
    else
      @player_turn = true
    end
  end

  def open_cards
    @res = ''
   
    if (@players[0].hand.count_cards > 21 || @players[0].hand.count_cards < @players[1].hand.count_cards) && @players[1].hand.count_cards < 22
      winner(@players[1])
    else
      if @players[0].hand.count_cards == @players[1].hand.count_cards || @players[0].hand.count_cards > 21 && @players[1].hand.count_cards > 21
        tie
      else
        winner(@players[0])
      end
    end
    end_game
    unless @game_over
      @players[0].hand.cards.clear
      @players[1].hand.cards.clear
      start_game
      @res
    end
  end

  def tie
    @players[0].money += 10
    @players[1].money += 10
    @res = 'Ничья'
  end
  
  def winner(player)
    player.money += 20
    @res = "#{player.name} побеждает"
  end

  def end_game
    if @players[0].money < 10
      @game_over = true
      @res += 'У вас закончились деньги'
    else
      if @players[1].money < 10
        @game_over = true
        @res += ' У диллера закончились деньги'
      end
    end
  end
end
