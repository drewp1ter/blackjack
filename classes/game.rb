require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative '../modules/display'
require_relative '../modules/utils'

class Game
  
  include Utils
  include Display
  
  BLACKJACK = 21
  
  def initialize(player)
    @bet = 0
    @player = player
    @dealer = Dealer.new
    @deck = Deck.new
  end
  
  def start!
    raise "У Вас нет денег!" if @player.cash == 0
    procs = [proc { next }, proc { player_hit_me! }, proc { dealer_step }, proc { break if check_status(true) } ]
    place_bet #делаем ставку
    give_out_cards # раздаем карты игрокам
    loop do
      break if check_status(false) #проверяем статус игры или вдруг у игрока уже блекджек?
      display(@player, @dealer, @bet, false)
      procs[keypress.to_i].call rescue next 
    end
    @bet = 0
    display(@player, @dealer, @bet, true)
    @player.cards_clear
  end
  
  private
  # делаем ставки
  def place_bet # не ругайсо, понимаю, что это трудно читаемо :)
    chips = ['', '', '']
    bets = [proc { @bet > 0 ? break : next }, proc { bet!(10) }, proc { bet!(30) }, proc { bet!(50) }]
    loop do
      display_chips(chips, @bet)
      i = keypress.to_i
      chips[i - 1] += '@' if bets[i].call rescue bets.first.call    
    end
  end
  
  def give_out_cards
    2.times do
      @player.give_cards(@deck.take_card)
      @dealer.give_cards(@deck.take_card)
    end  
  end
  
  def player_hit_me!
    @player.give_cards(@deck.take_card)
  end
  
  def dealer_step    
    unless @dealer.step(@deck) 
      puts "Dealer skipped!"
      sleep(1)
    end  
  end  
  
  def player_win
    @player.change_cash(@bet * 2)
    display_winner(PLAYER_WIN)
  end
  
  def dealer_win
    display_winner(DEALER_WIN)
  end

  def stay
    @player.change_cash(@bet)
    display_winner(STAY)
  end
  
  def bet!(bet)
    @player.change_cash(-bet) ? !!(@bet += bet) : false
  end
  # проверка статуса игры и поиск выйгравшего, endpart - закончена ли игра пользователем
  def check_status(endpart)
    rezult = false
    if endpart
      if @dealer.score == @player.score
        stay
      else
        @dealer.score < @player.score ? player_win : dealer_win 
      end 
      rezult = true
    else  
      if @player.score == BLACKJACK || @dealer.score > BLACKJACK && @player.score <= BLACKJACK
        player_win
        rezult = true
      elsif @player.score > BLACKJACK  
        dealer_win  
        rezult = true
      elsif  
        @player.cards_count == 3  &&  @dealer.cards_count == 3    
        rezult = check_status(true) 
      end  
    end
    rezult
  end

end
