require_relative 'classes/game'
require_relative 'classes/player'
require_relative 'modules/utils'

include Utils

START_CASH = 100

begin
  puts 'Как вас зовут?'
  player_name = gets.chomp.capitalize
  player = Player.new(player_name, START_CASH)
  loop do
    game = Game.new(player)
    game.start! 
    break if keypress.downcase == 'n'
  end  
  rescue RuntimeError => e 
    puts e.message
end  
