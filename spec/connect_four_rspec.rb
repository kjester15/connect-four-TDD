require_relative '../lib/connect_four'

describe Game do
  subject(:game_main) { described_class.new }

  describe '#initialize' do
    # Initialize -> No test necessary when only creating instance variables.
  end

  describe '#print_board' do
    # method only prints to terminal - no test necessary
  end

  describe '#make_selection' do
  end
end
