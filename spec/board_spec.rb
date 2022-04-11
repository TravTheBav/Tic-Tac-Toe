# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#winner?' do
    context 'when there is no winner' do
      before do
        allow(board).to receive(:check_rows).and_return(false)
        allow(board).to receive(:check_cols).and_return(false)
        allow(board).to receive(:check_diagonals).and_return(false)
      end
      
      it 'returns false' do
        expect(board).not_to be_winner
      end
    end

    context 'when a row has three of the same symbol' do
      before do
        allow(board).to receive(:check_rows).and_return(true)
        allow(board).to receive(:check_cols).and_return(false)
        allow(board).to receive(:check_diagonals).and_return(false)
      end

      it 'returns true' do
        expect(board).to be_winner
      end
    end

    context 'when a column has three of the same symbol' do
      before do
        allow(board).to receive(:check_rows).and_return(false)
        allow(board).to receive(:check_cols).and_return(true)
        allow(board).to receive(:check_diagonals).and_return(false)
      end

      it 'returns true' do
        expect(board).to be_winner
      end
    end

    context 'when a diagonal has three of the same symbol' do
      before do
        allow(board).to receive(:check_rows).and_return(false)
        allow(board).to receive(:check_cols).and_return(false)
        allow(board).to receive(:check_diagonals).and_return(true)
      end

      it 'returns true' do
        expect(board).to be_winner
      end
    end
  end

  describe '#full?' do
    context 'when board has empty spaces' do
      it 'returns false' do
        expect(board).not_to be_full
      end
    end

    context 'when some spaces are filled' do
      before do
        board.instance_variable_set(:@rows, [
          ['_', :X, '_'],
          [:O, '_', :X],
          [:O, :X, '_']
        ])
      end

      it 'returns false' do
        expect(board).not_to be_full
      end
    end

    context 'when board has no more empty spaces' do
      before do
        board.instance_variable_set(:@rows, Array.new(3) { Array.new(3, :X) })      
      end      
      
      it 'returns true' do
        expect(board).to be_full
      end
    end
  end

  describe '#check_rows' do
    context 'when all rows are empty' do
      it 'returns false' do
        result = board.check_rows
        expect(result).to be false
      end
    end

    context 'when a row is full but not a three of a kind match' do
      before do
        board.instance_variable_set(:@rows, [
          ['_', '_', '_'],
          [:X, :O, :X],
          ['_', '_', '_']
        ])
      end

      it 'returns false' do
        result = board.check_rows
        expect(result).to be false
      end
    end

    context "when a row contains three X's" do
      before do
        board.instance_variable_set(:@rows, [
            ['_', '_', '_'],
            [:X, :X, :X],
            ['_', '_', '_']
        ])
      end

      it 'returns true' do
        result = board.check_rows
        expect(result).to be true
      end
    end
  end

  describe '#check_cols' do
    context 'when all columns are empty' do
      it 'returns false' do
        result = board.check_cols
        expect(result).to be false
      end
    end

    context 'when a column is full but not a three of a kind match' do
      before do
        board.instance_variable_set(:@rows, [
            [:X, '_', '_'],
            [:X, '_', '_'],
            [:O, '_', '_']
        ])
      end

      it 'returns false' do
        result = board.check_cols
        expect(result).to be false
      end
    end

    context "when a column contains three X's" do
      before do
        board.instance_variable_set(:@rows, [
            ['_', '_', :X],
            ['_', '_', :X],
            ['_', '_', :X]
        ])
      end

      it 'returns true' do
        result = board.check_cols
        expect(result).to be true
      end
    end
  end

  describe '#check_diagonals' do
    context 'when neither diagonal contains a three of a kind match' do
      before do
        allow(board).to receive(:check_diagonal_dexter).and_return(false)
        allow(board).to receive(:check_diagonal_sinister).and_return(false)
      end

      it 'returns false' do
        result = board.check_diagonals
        expect(result).to be false
      end
    end

    context 'when a diagonal contains a three of a kind match' do
      before do
        allow(board).to receive(:check_diagonal_dexter).and_return(false)
        allow(board).to receive(:check_diagonal_sinister).and_return(true)
      end

      it 'returns true' do
        result = board.check_diagonals
        expect(result).to be true
      end
    end
  end

  describe '#check_diagonal_dexter' do
    context 'when the diagonal from top left to bottom right does not contain a match' do
      before do
        board.instance_variable_set(:@rows, [
          [:X, '_', '_'],
          ['_', :O, '_'],
          ['_', '_', :X]
        ])
      end
      
      it 'returns false' do
        result = board.check_diagonal_dexter
        expect(result).to be false
      end
    end

    context "when the diagonal from top left to bottom right contains three X's" do
      before do
        board.instance_variable_set(:@rows, [
          [:X, '_', '_'],
          ['_', :X, '_'],
          ['_', '_', :X]
        ])
      end

      it 'returns true' do
        result = board.check_diagonal_dexter
        expect(result).to be true
      end
    end
  end

  describe '#check_diagonal_sinister' do
    context 'when the diagonal from bottom left to top right does not contain a match' do
      before do
        board.instance_variable_set(:@rows, [
          ['_', '_', :O],
          ['_', :X, '_'],
          [:O, '_', '_']
        ])
      end

      it 'returns false' do
        result = board.check_diagonal_sinister
        expect(result).to be false
      end
    end

    context "when the diagonal from bottom left to top right contains three X's" do
      before do
        board.instance_variable_set(:@rows, [
          ['_', '_', :X],
          ['_', :X, '_'],
          [:X, '_', '_']
        ])
      end

      it 'returns true' do
        result = board.check_diagonal_sinister
        expect(result).to be true
      end
    end
  end

  describe '#valid_pos?' do
    context "when given a string that is not a comma seperated coordinate" do
      it 'returns false' do
        result = board.valid_pos?('foobar')
        expect(result).to be false
      end
    end

    context "when given a coordinate that is out of the board's range" do
      it 'returns false' do
        result = board.valid_pos?('5,4')
        expect(result).to be false
      end
    end

    context 'when given a comma seperated coordinate with two values within range 0-2' do
      it 'returns true' do
        result = board.valid_pos?('0,1')
        expect(result).to be true
      end
    end
  end

end