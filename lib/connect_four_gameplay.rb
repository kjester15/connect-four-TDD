require_relative '../lib/connect_four'

game = Game.new
game.greeting_setup
game.print_board
until game.game_finished == true
  game.update_board(game.make_selection)
  game.update_player_turn
end
