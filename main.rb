# frozen_string_literal: true

require_relative 'deck'
require_relative 'logic'

class UI
  def initialize; end

  def start
    puts 'Введите имя:'
    name = gets.chomp
    @game = Game.new(name.to_s)
    menu
  end

  def menu
    puts "У вас в банке #{@game.players[0].money}, у диллера #{@game.players[1].money}, в банке 20"
    print 'У вас в руке: '
    @game.players[0].hand.each { |card| print "#{card.name} " }
    puts ", общая сумма #{@game.players[0].cards_value}"
    print 'У диллера в руке '
    @game.players[1].hand.each { print ' **' }
    puts ' '
    puts 'Возможные действия:'
    puts '1.Пропустить ход'
    puts '2.Добавить карту' if @game.players[0].hand.length == 2
    puts '3.Вскрыть карты'
    puts '0.Выход'
    choose = gets.chomp.to_i
    if @game.players[0].hand.length == 2 && choose == 2
      @game.add_card
    else
      case choose
      when 1
        @game.skip
      when 3
        print 'Ваши карты:'
        @game.players[0].hand.each { |card| print "#{card.name} " }
        puts ", общая сумма #{@game.players[0].cards_value}"
        print 'Карты диллера:'
        @game.players[1].hand.each { |card| print "#{card.name} " }
        puts ", общая сумма #{@game.players[1].cards_value}"
        puts @game.open_cards
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
