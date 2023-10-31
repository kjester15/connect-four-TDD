# Player class is used to create player 1 and player 2
class Player
  def initialize
    @name = ''
    @symbol = ''
  end
end

# Game class is used to create the Game board and methods
class Game
  attr_accessor :board_array

  def initialize
    @board_array = [%w[a1 a2 a3 a4 a5 a6 a7], %w[b1 b2 b3 b4 b5 b6 b7], %w[c1 c2 c3 c4 c5 c6 c7],
                    %w[d1 d2 d3 d4 d5 d6 d7], %w[e1 e2 e3 e4 e5 e6 e7], %w[f1 f2 f3 f4 f5 f6 f7]]
  end

  def print_board
    @board_array.each do |x|
      puts '- - - - - - - - - - - - - - - - -'
      x.each do |y|
        print "#{y} | "
      end
      puts
    end
    puts '- - - - - - - - - - - - - - - - -'
  end

end

game = Game.new
game.print_board
