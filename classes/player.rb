require_relative 'deck'

class Player
  
  attr_reader  :name, :cash

  def initialize(name, cash)
    raise 'WTF name?' if name !~ /^\w{3,12}$/
    @cash = cash
    @name = name
    @cards = 0
  end
  
  def change_cash(amount)
    @cash + amount >= 0 ? !!(@cash += amount) : false
  end
  
  def score
    Deck.score(@cards)
  end
   
  def give_cards(cards)
    @cards += cards
  end
  
  def cards_clear
    @cards = 0
  end
  
  def cards_text
    Deck.to_s(@cards)
  end

  def cards_count
    Deck.count(@cards)
  end
  
end