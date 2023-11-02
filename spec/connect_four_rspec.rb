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
    context 'when invalid selections are made before a valid selection' do
      before do
        allow(game_main).to receive(:gets).and_return(8, 'a', 2)
      end

      it 'ends loop when valid selection is made' do
        initial_prompt = 'Choose a column, 1-7, to drop your piece into.'
        retry_prompt = 'Please choose a valid column to drop your piece.'
        expect(game_main).to receive(:puts).with(initial_prompt).once
        expect(game_main).to receive(:puts).with(retry_prompt).twice
        game_main.make_selection
      end
    end

    context 'when a valid selection is made' do
      before do
        allow(game_main).to receive(:gets).and_return(4)
      end

      it 'accepts 4' do
        prompt = 'Choose a column, 1-7, to drop your piece into.'
        expect(game_main).to receive(:puts).with(prompt).once
        result = game_main.make_selection
        expect(result).to eq(4)
      end
    end

    context 'when a valid edge selection is made' do
      before do
        allow(game_main).to receive(:gets).and_return(1)
      end

      it 'accepts 1' do
        prompt = 'Choose a column, 1-7, to drop your piece into.'
        expect(game_main).to receive(:puts).with(prompt).once
        result = game_main.make_selection
        expect(result).to eq(1)
      end
    end

    context 'when a column is full' do
      before do
        allow(game_main).to receive(:gets).and_return(1)
      end

      xit 'does not accept the column as a valid selection' do
        game_main.board_array = [['x', ' ', ' ', ' ', ' ', ' ', ' '], ['x', ' ', ' ', ' ', ' ', ' ', ' '],
                                 ['x', ' ', ' ', ' ', ' ', ' ', ' '], ['x', ' ', ' ', ' ', ' ', ' ', ' '],
                                 ['x', ' ', ' ', ' ', ' ', ' ', ' '], ['x', ' ', ' ', ' ', ' ', ' ', ' ']]
        initial_prompt = 'Choose a column, 1-7, to drop your piece into.'
        retry_prompt = 'Please choose a valid column to drop your piece.'
        expect(game_main).to receive(:puts).with(initial_prompt).once
        expect(game_main).to receive(:puts).with(retry_prompt).once
        game_main.make_selection
      end
    end
  end

  describe '#check_column' do
    subject(:game_main) { described_class.new }

    context 'when a column is not full' do
      it 'returns false' do
        # array = [[' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' '],
        #          [' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' '],
        #          [' ', ' ', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ']]
        selection = 1
        result = game_main.check_column(selection)
        expect(result).to be false
      end
    end

    context 'when a column is full' do
      it 'returns true' do
        array = [['x', ' ', ' ', ' ', ' ', ' ', ' '], ['x', ' ', ' ', ' ', ' ', ' ', ' '],
                 ['x', ' ', ' ', ' ', ' ', ' ', ' '], ['x', ' ', ' ', ' ', ' ', ' ', ' '],
                 ['x', ' ', ' ', ' ', ' ', ' ', ' '], ['x', ' ', ' ', ' ', ' ', ' ', ' ']]
        game_main.instance_variable_set(:@board_array, array)
        selection = 1
        result = game_main.check_column(selection)
        expect(result).to be true
      end
    end
  end
end
