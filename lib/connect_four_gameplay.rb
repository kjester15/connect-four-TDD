require_relative '../lib/connect_four'

game = Game.new
game.greeting_setup
game.print_board
until game.game_finished == true
  game.update_board(game.make_selection)
  game.print_board
  game.check_win(game.last_position.dup)
  game.update_player_turn
end
