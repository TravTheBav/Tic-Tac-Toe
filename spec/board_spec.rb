# frozen_string_literal: true

require_relative '../lib/board'

describe Board do 

  describe '#winner?' do
    subject(:board) { described_class.new }

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
    subject(:board) { described_class.new }

    context 'when board has empty spaces' do
      it 'returns false' do
        expect(board).not_to be_full
      end
    end

    context 'when some spaces are filled' do
      before do
        board.instance_variable_set(:@rows, [
          ['_', 'X', '_'],
          ['O', '_', 'X'],
          ['O', 'X', '_']
        ])
      end

      it 'returns false' do
        expect(board).not_to be_full
      end
    end

    context 'when board has no more empty spaces' do
      before do
        board.instance_variable_set(:@rows, Array.new(3) { Array.new(3, 'X') })      
      end      
      
      it 'returns true' do
        expect(board).to be_full
      end
    end
  end

end