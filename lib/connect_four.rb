# frozen_string_literal: true

require 'pry-byebug'

# Game class is used to create the Game board and methods
class Game
  attr_accessor :board_array, :player1, :player2, :player_turn, :game_finished, :last_position

  def initialize(board_array = Array.new(6) { Array.new(7) { ' ' } }, player1 = { name: 'kyle', symbol: 'x' }, player2 = { name: 'cat', symbol: 'y' })
    # https://www.theodinproject.com/lessons/ruby-nested-collections
    # created immutable nested array for board_array
    @board_array = board_array
    @player1 = player1
    @player2 = player2
    @player_turn = @player1
    @game_finished = false
    @last_position = []
  end

  def greeting_setup
    puts 'Hello! Welcome to Connect Four. Let\'s play a game in the console.'
    puts 'What is player 1\'s name?'
    @player1[:name] = gets.chomp
    puts 'What is player 1\'s symbol?'
    @player1[:symbol] = gets.chomp
    until @player1[:symbol].length == 1
      puts 'Please choose a letter that is only 1 character long.'
      @player1[:symbol] = gets.chomp
    end
    puts 'What is player 2\'s name?'
    @player2[:name] = gets.chomp
    puts 'What is player 2\'s symbol?'
    @player2[:symbol] = gets.chomp
    until @player2[:symbol].length == 1 && @player2[:symbol] != @player1[:symbol]
      puts 'Please choose a letter that is only 1 character long, and has not been chosen by Player 1.'
      @player2[:symbol] = gets.chomp
    end
    puts "You'll take turns choosing a column to 'drop' your piece into, choosing a number between 1 and 7. Get 4 in \
a row and you win!"
    puts "Here is your board - #{@player1[:name]}, you go first!"
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
    column_full = check_column(selection)
    until ((1..7).include? selection) && (column_full == false)
      puts 'Please choose a valid column to drop your piece.'
      selection = gets.to_i
      column_full = check_column(selection)
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

  def update_board(selection)
    index = selection - 1
    start = -1
    6.times do
      if @board_array[start][index] == ' '
        @board_array[start][index] = @player_turn[:symbol]
        @last_position = [@board_array.length + start, index]
        break
      else
        start -= 1
      end
    end
  end

  def update_player_turn
    if @player_turn == @player1
      @player_turn = @player2
    elsif @player_turn == @player2
      @player_turn = @player1
    end
  end

  def in_bounds?(position)
    if position[0].between?(0, 5)
      if position[1].between?(0, 6)
        true
      end
    end
  end

  def check_win(current_position, direction = 'up', score = 1)
    if score == 4
      @game_finished = true
      return
    end

    case direction
    when 'up'
      current_position[0] -= 1
      if in_bounds?(current_position)
        if @board_array[current_position[0]][current_position[1]] == @player_turn[:symbol]
          score += 1
          check_win(current_position, 'up', score)
        else
          check_win(@last_position.dup, 'right')
        end
      else
        check_win(@last_position.dup, 'right')
      end
    when 'right'
      current_position[1] += 1
      if in_bounds?(current_position)
        if @board_array[current_position[0]][current_position[1]] == @player_turn[:symbol]
          score += 1
          check_win(current_position, 'right', score)
        else
          check_win(@last_position.dup, 'down')
        end
      else
        check_win(@last_position.dup, 'down')
      end
    when 'down'
      current_position[0] += 1
      if in_bounds?(current_position)
        if @board_array[current_position[0]][current_position[1]] == @player_turn[:symbol]
          score += 1
          check_win(current_position, 'down', score)
        else
          check_win(@last_position.dup, 'left')
        end
      else
        check_win(@last_position.dup, 'left')
      end
    when 'left'
      current_position[1] -= 1
      if in_bounds?(current_position)
        if @board_array[current_position[0]][current_position[1]] == @player_turn[:symbol]
          score += 1
          check_win(current_position, 'left', score)
        else
          check_win(@last_position.dup, 'diag_up_left')
        end
      else
        check_win(@last_position.dup, 'diag_up_left')
      end
    when 'diag_up_left'
      current_position[0] -= 1
      current_position[1] -= 1
      if in_bounds?(current_position)
        if @board_array[current_position[0]][current_position[1]] == @player_turn[:symbol]
          score += 1
          check_win(current_position, 'diag_up_left', score)
        else
          check_win(@last_position.dup, 'diag_up_right')
        end
      else
        check_win(@last_position.dup, 'diag_up_right')
      end
    when 'diag_up_right'
      current_position[0] -= 1
      current_position[1] += 1
      if in_bounds?(current_position)
        if @board_array[current_position[0]][current_position[1]] == @player_turn[:symbol]
          score += 1
          check_win(current_position, 'diag_up_right', score)
        else
          check_win(@last_position.dup, 'diag_down_left')
        end
      else
        check_win(@last_position.dup, 'diag_down_left')
      end
    when 'diag_down_left'
      current_position[0] += 1
      current_position[1] -= 1
      if in_bounds?(current_position)
        if @board_array[current_position[0]][current_position[1]] == @player_turn[:symbol]
          score += 1
          check_win(current_position, 'diag_down_left', score)
        else
          check_win(@last_position.dup, 'diag_down_right')
        end
      else
        check_win(@last_position.dup, 'diag_down_right')
      end
    when 'diag_down_right'
      current_position[0] += 1
      current_position[1] += 1
      if in_bounds?(current_position)
        if @board_array[current_position[0]][current_position[1]] == @player_turn[:symbol]
          score += 1
          check_win(current_position, 'diag_down_right', score)
        end
      end
    end
  end
end
