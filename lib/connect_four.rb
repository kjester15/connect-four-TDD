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
    @board_array = [[' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' '],
                    [' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' '],
                    [' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ']]
    @player1_name = ''
    @player2_name = ''
    @player1_symbol = ''
    @player2_symbol = ''
  end

  def greeting_setup
    puts 'Hello! Welcome to Connect Four. Let\'s play a game in the console.'
    puts 'What is player 1\'s name?'
    @player1_name = gets.chomp
    puts 'What is player 1\'s symbol?'
    @player1_symbol = gets.chomp
    until @player1_symbol.length == 1
      puts 'Please choose a letter that is only 1 character long.'
      @player1_symbol = gets.chomp
    end
    puts 'What is player 2\'s name?'
    @player2_name = gets.chomp
    puts 'What is player 2\'s symbol?'
    @player2_symbol = gets.chomp
    until @player2_symbol.length == 1 && @player2_symbol != @player1_symbol
      puts 'Please choose a letter that is only 1 character long, and has not been chosen by Player 1.'
      @player2_symbol = gets.chomp
    end
    puts "You'll take turns choosing a column to 'drop' your piece into, choosing a number between 1 and 7. Get 4 in \
a row and you win!"
    puts "Here is your board - #{@player1_name}, you go first!"
  end

  def print_board
    @board_array.each do |x|
      puts ' - - - - - - - - - - - - - -'
      print '| '
      x.each do |y|
        print "#{y} | "
      end
      puts
    end
    puts ' - - - - - - - - - - - - - -'
    puts '  1   2   3   4   5   6   7  '
  end
end

