# Game class is used to create the Game board and methods
class Game
  attr_accessor :board_array, :player1_name, :player1_symbol, :player2_name, :player2_symbol

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
    @board_array.each do |row|
      puts ' - - - - - - - - - - - - - -'
      print '| '
      row.each do |column|
        print "#{column} | "
      end
      puts
    end
    puts ' - - - - - - - - - - - - - -'
    puts '  1   2   3   4   5   6   7  '
  end

  def make_selection
    puts 'Choose a column, 1-7, to drop your piece into.'
    selection = gets.to_i
    until (1..7).include? selection
      puts 'Please choose a valid column to drop your piece.'
      selection = gets.to_i
    end
    selection
  end

  def check_column(column)
    index = column - 1
    @board_array.each do |row|
      if row[index] == ' '
        return false
      end
    end
    true
  end
end

