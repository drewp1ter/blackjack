require_relative 'utils'

module Display
  
  PLAYER_WIN = "Вы выйграли!"
  DEALER_WIN = "Вы проиграли!"
  STAY = "Ничья!"
  
  def aligment(str, len = 18)
    str += ' ' while str.length < len
    str 
  end
  
  def display_winner(winner)
    @totaltext = winner
  end
  
  def display_chips(chips, bet)
    clrscr
    puts '########################## BET ############################'
    puts aligment("Cash: #{ @player.cash }$; Bet: #{ bet }$", 58) + '#'
    puts "# 1 => 10$ : #{aligment(chips[0], 45)}#"
    puts "# 2 => 30$ : #{aligment(chips[1], 45)}#"
    puts "# 3 => 50$ : #{aligment(chips[2], 45)}#"
    puts '###########################################################'
  end
  
  def display(player, dealer, bet, endpart)
    clrscr
    puts '###################### BLACKJACK ##########################'
    puts aligment("# Cash: #{ @player.cash }$; Bet: #{ bet }$", 58) + '#'
    puts "# #{aligment('Dealer', 17)} #{ endpart ? aligment(@dealer.cards_text) : aligment(@dealer.cards_hide_text) }" + 
    " Score: #{ aligment(endpart ? @dealer.score.to_s :  "?", 12) }#"
    puts "# #{aligment(player.name, 17)} #{ aligment(@player.cards_text) } Score: #{ aligment(@player.score.to_s, 12) }#"
    puts aligment(endpart ? "# #{@totaltext} Начать новую игру? [y/n]" : "# 1 - добавить карту; 2 - пропустить; 3 - открыть карты", 58) + "#"
    puts '###########################################################' 
  end
  
end