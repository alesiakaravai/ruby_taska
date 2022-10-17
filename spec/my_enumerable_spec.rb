# frozen_string_literal: true

require 'rspec'

require_relative '../my_enumerable'

RSpec.describe MyEnumerable do
  let(:arr) { [1, 2, 3, 4] }

  describe '#my_all?' do
    context 'when no argument and no block given' do
      it { expect(arr.my_all?).to eq(true) }
      it { expect([].my_all?).to eq(true) }
    end

    context 'when argument and no block given' do
      it { expect(arr.my_all?(Integer)).to eq(true) }
      it { expect([].my_all?(Integer)).to eq(true) }
    end

    context 'when block given' do
      it { expect(arr.my_all? { |element| element < 5 }).to eq(true) }
    end

    context 'when empty array' do
      it { expect([].my_all?).to eq(true) }
    end
  end

  describe '#my_any?' do
    context 'when no argument and no block given' do
      it { expect([1, false, nil].my_any?).to eq(true) }
    end

    context 'when argument pattern and no block given' do
      it { expect([nil, false, 0].my_any?(Integer)).to eq(true) }
    end

    context 'when no pattern and block given' do
      it { expect(arr.my_any? { |element| element < 2 }).to eq(true) }
    end

    context 'when empty array' do
      it { expect([].my_any?).to eq(false) }
    end
  end

  describe '#my_none?' do
    context 'when no argument and no block given' do
      it { expect([nil, false].my_none?).to eq(true) }
      it { expect([].my_none?).to eq(true) }
    end
    context 'when argument and no block given' do
      it { expect([nil, false, 1.1].my_none?(Integer)).to eq(true) }
      it { expect([].my_none?(Integer)).to eq(true) }
    end
    context 'when block given' do
      it { expect(arr.my_none? { |element| element < 1 }).to eq(true) }
    end
    context 'when empty array' do
      it { expect([].my_none?).to eq(true) }
    end
  end

  describe '#my_reject?' do
    context 'when no argument and no block given' do
      it { expect(arr.my_reject) == arr.to_enum(:my_reject) }
    end
    context 'when argument and no block given' do
      it { expect { arr.my_reject 5 }.to raise_error(ArgumentError) }
    end
    context 'when a block given' do
      it { expect([0, 1, 2, 3, 4, 5, 6, 7, 8, 9].my_reject(&:even?)).to eq([1, 3, 5, 7, 9]) }
    end
  end

  describe '#my_min?' do
    context 'when no argument and no block given' do
      it { expect(arr.my_min).to eq(1) }
    end
    context 'when argument and no block given' do
      it { expect(arr.my_min(3)).to eq([1, 2, 3]) }
    end
    context 'when no argument and block given' do
      it { expect(arr.my_min { |a, b| a <=> b }).to eq(1) }
    end
    context 'when argument and block given' do
      it { expect(arr.my_min(2) { |a, b| a <=> b }).to eq([1, 2]) }
    end
    context 'when empty array' do
      it { expect([].my_min).to eq(nil) }
      it { expect([].my_min(5)).to eq([]) }
    end
  end

  describe '#my_max?' do
    context 'when no argument and no block given' do
      it { expect(arr.my_max).to eq(4) }
    end
    context 'when argument and no block given' do
      it { expect(arr.my_max(3)).to eq([4, 3, 2]) }
    end
    context 'when no argument and block given' do
      it { expect(arr.my_max { |a, b| a <=> b }).to eq(4) }
    end
    context 'when argument and block given' do
      it { expect(arr.my_max(2) { |a, b| a <=> b }).to eq([4, 3]) }
    end
    context 'when empty array' do
      it { expect([].my_max).to eq(nil) }
      it { expect([].my_max(5)).to eq([]) }
    end
  end

  describe '#my_find_index' do
    context 'when no argument and no block given' do
      it { expect(arr.my_find_index) == arr.to_enum(:my_find_index) }
    end
    context 'when argument and no block given' do
      it { expect(arr.my_find_index(2)).to eq(1) }
    end
    context 'when block and no argument given' do
      it { expect(arr.my_find_index { |x| x > 3 }).to eq(3) }
    end
    context 'when empty array' do
      it { expect([].my_find_index(3)).to eq(nil) }
      it { expect([].my_find_index) == arr.to_enum(:my_find_index) }
    end
  end

  describe '#my_find' do
    context 'when no argument and no block given' do
      it { expect(arr.my_find) == arr.to_enum(:my_find) }
    end
    context 'when proc argument and no block given' do
      it { expect(arr.my_find(proc { false })) == arr.to_enum(:my_find, proc { false }) }
    end
    context 'when proc argument and block given' do
      it { expect(arr.my_find(proc { false }) { |x| x > 10 }).to eq(false) }
      it { expect(arr.my_find(proc { false }) { |x| x > 2 }).to eq(3) }
    end
    context 'when no argument and block given' do
      it { expect(arr.my_find { |x| x > 2 }).to eq(3) }
      it { expect(arr.my_find { |x| x > 10 }).to eq(nil) }
    end
    context 'when argument != proc and block given' do
      it { expect(arr.my_find(3) { |x| x > 2 }).to eq(3) }
      it { expect { arr.my_find(3) { |x| x > 10 } }.to raise_error(NoMethodError) }
    end
    context 'when argument != proc and no block given' do
      it { expect(arr.my_find(3)) == arr.to_enum(:my_find) }
    end
    context 'when empty array' do
      it { expect([].my_find { |x| x > 2 }).to eq(nil) }
    end
  end

  describe '#my_find_all' do
    context 'when no argument and no block given' do
      it { expect(arr.my_find_all) == arr.to_enum(:my_find_all) }
    end
    context 'when argument and no block given' do
      it { expect { arr.my_find_all(3) }.to raise_error(ArgumentError) }
    end
    context 'when no argument and block given' do
      it { expect(arr.my_find_all { |x| x > 2 }).to eq([3, 4]) }
    end
  end

  describe '#my_select' do
    context 'when no argument and no block given' do
      it { expect(arr.my_select) == arr.to_enum(:my_select) }
    end
    context 'when argument and no block given' do
      it { expect { arr.my_select(3) }.to raise_error(ArgumentError) }
    end
    context 'when no argument and block given' do
      it { expect(arr.my_select { |x| x > 2 }).to eq([3, 4]) }
    end
  end

  describe '#my_count' do
    context 'when no argument and no block given' do
      it { expect(arr.my_count).to eq(4) }
    end
    context 'when argument and no block given' do
      it { expect([0, 1, 2, 1].my_count(1)).to eq(2) }
    end
    context 'when no argumen and block given' do
      it { expect(arr.my_count { |element| element < 3 }).to eq(2) }
    end
  end

  describe '#my_map' do
    context 'when no argument and no block given' do
      it { expect(arr.my_map) == arr.to_enum(:my_map) }
    end
    context 'when argument given' do
      it { expect { arr.my_map(5) }.to raise_error(ArgumentError) }
    end
    context 'when block given' do
      it { expect(arr.my_map { |i| i * 2 }).to eq([2, 4, 6, 8]) }
    end
  end

  describe '#my_include?' do
    context 'when no argument' do
      it { expect { arr.my_include? }.to raise_error(ArgumentError) }
    end
    context 'when argument' do
      it { expect(arr.my_include?(2)).to eq(true) }
    end
    context 'when a block given' do
    end
  end
end
