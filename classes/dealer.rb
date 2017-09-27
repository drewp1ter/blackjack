require_relative 'player'

class Dealer < Player
  
  def initialize(name = 'Dealer', cash = 0)
    super
  end
  # ход диллера, если очков меньше 17 - берем карту, иначе пропускаем ход
  def step(deck)
    return false if score >= 17 
    give_cards(deck.take_card)
    true 
  end
  
  def cards_hide_text
    str = ''
    cards_count.times { str += '|**| ' }
    str
  end
  
end