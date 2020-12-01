# frozen_string_literal: true

require_relative 'deck'
require_relative 'logic'
require_relative 'hand'
require_relative 'card'

class UI
  def start
    puts 'Введите имя:'
    name = gets.chomp
    @game = Game.new(name.to_s)
    menu
  end

  def menu
    info_list
    puts ' '
    action_list
    choose = gets.chomp.to_i
    if @game.players[0].hand.too_much? && choose == 2
      @game.add_card
    else
      case choose
      when 1
        @game.skip
      when 3
        open_cards
      when 0
        abort
      end
    end

    if @game.game_over
      game_over
    else
      menu
    end
  end

  private

  def info_list
    puts "У вас в банке #{@game.players[0].money}, у диллера #{@game.players[1].money}, в банке 20"
    print 'У вас в руке: '
    @game.players[0].hand.cards.each { |card| print "#{card.value}#{card.suit}  " }
    puts ", общая сумма #{@game.players[0].hand.count_cards}"
    print 'У диллера в руке '
    @game.players[1].hand.cards.each { print ' **' }
  end

  def action_list
    puts 'Возможные действия:'
    puts '1.Пропустить ход'
    puts '2.Добавить карту' if @game.players[0].hand.too_much?
    puts '3.Вскрыть карты'
    puts '0.Выход'
  end

  def open_cards
    print 'Ваши карты:'
    @game.players[0].hand.cards.each { |card| print "#{card.value}#{card.suit} " }
    puts ", общая сумма #{@game.players[0].hand.count_cards}"
    print 'Карты диллера:'
    @game.players[1].hand.cards.each { |card| print "#{card.value} #{card.suit}  " }
    puts ", общая сумма #{@game.players[1].hand.count_cards}"
    puts @game.open_cards
  end

  def game_over
    puts '1.Начать заного'
    puts '0.Выйти'

    case gets.chomp
    when 1
      @game = nil
      start
    when 0
      abort
    end
  end
  
end

ui = UI.new
ui.start
