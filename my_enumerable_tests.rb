# frozen_string_literal: true

require 'rspec'

require_relative './my_enumerable'

RSpec.describe MyEnumerable do
  it 'test_my_all?' do
    expect([1, 2, 3, 4].my_all?).to eq(true)
    expect(%w[a b c d].my_all?).to eq(true)
    expect([1, 2, nil].my_all?).to eq(false)
    expect(['a', 'b', false].my_all?).to eq(false)
    expect([].all?).to eq(true)
    expect([1, 2, 3, 4].all?(Integer)).to eq(true)
    expect([1, 2, 3, 4].all?(Numeric)).to eq(true)
    expect([1, 2, 3, 4].all?(Float)).to eq(false)
    expect(%w[bar baz bat bam].all?(/ba/)).to eq(true)
    expect(%w[bar baz bat bam].all?(/bar/)).to eq(false)
    expect(%w[bar baz bat bam].all?('ba')).to eq(false)
  end

  it 'test_my_any?' do
    expect([1, 2, 3, 4].my_any?).to eq(true)
    expect(%w[a b c d].my_any?).to eq(true)
    expect([1, false, nil].my_any?).to eq(true)
    expect([].any?).to eq(false)
    expect([nil, false, 0].any?(Integer)).to eq(true)
    expect([nil, false, 0].any?(Numeric)).to eq(true)
    expect([nil, false, 0].any?(Float)).to eq(false)
    expect(%w[bar baz bat bam].any?(/m/)).to eq(true)
    expect(%w[bar baz bat bam].any?(/foo/)).to eq(false)
    expect(%w[bar baz bat bam].any?('ba')).to eq(false)

    expect([].any?(Integer)).to eq(false)
    expect([1, 2, 3, 4].any? { |element| element < 1 }).to eq(false)
    expect([1, 2, 3, 4].any? { |element| element < 2 }).to eq(true)
  end

  it 'test_my_none?' do
    expect([1, 2, 3, 4].my_none?).to eq(false)
    expect([nil, false].my_none?).to eq(true)
    expect([].my_none?).to eq(true)
    expect([nil, false, 1.1].my_none?(Integer)).to eq(true)
    expect(%w[bar baz bat bam].my_none?(/m/)).to eq(false)
    expect(%w[bar baz bat bam].my_none?(/foo/)).to eq(true)
    expect(%w[bar baz bat bam].my_none?('ba')).to eq(true)

    expect([].my_none?(Integer)).to eq(true)
    expect([1, 2, 3, 4].my_none? { |element| element < 1 }).to eq(true)
    expect([1, 2, 3, 4].my_none? { |element| element < 2 }).to eq(false)
  end

  it 'test_my_reject?' do
    expect([0, 1, 2, 3, 4, 5, 6, 7, 8, 9].my_reject { |i| i * 2 if i.even? }).to eq([1, 3, 5, 7, 9])
  end

  it 'test_my_inject?' do
  end

  it 'test_my_min?' do
  end

  it 'test_my_max?' do
  end

  it 'test_my_find_index' do
    expect(%w[a b c b].my_find_index('b')).to eq(1)
    expect(%w[a b c b].my_find_index { |element| element.start_with?('b') }).to eq(1)
  end

  it 'test_my_find' do
    expect([0, 1, 2, 3, 4, 5, 6, 7, 8, 9].my_find { |element| element > 2 }).to eq(3)
    expect([0, 1, 2, 3, 4, 5, 6, 7, 8, 9].my_find { |element| element > 12 }).to eq(false)
  end

  it 'test_my_find_all' do
    expect([1, 2, 3, 4, 5, 6, 7, 8, 9, 10].my_find_all { |element| (element % 3).zero? }).to eq([3, 6, 9])
  end

  it 'test_my_select' do
    expect([1, 2, 3, 4, 5].my_select(&:even?)).to eq([2, 4])
  end

  it 'test_my_count' do
    expect([0, 1, 2].my_count).to eq(3)
    expect([0, 1, 2, 1].my_count(1)).to eq(2)
    expect([0, 1, 2, 3].my_count { |element| element < 2 }).to eq(2)
  end

  it 'test_my_map' do
    expect([0, 1, 2, 3, 4].my_map { |i| i * i }).to eq([0, 1, 4, 9, 16])
  end

  it 'test_my_include?' do
    expect([1, 2, 3, 4].my_include?(2)).to eq(true)
    expect([1, 2, 3, 4].my_include?(5)).to eq(false)
    expect([1, 2, 3, 4].my_include?('2')).to eq(false)
    expect(%w[a b c d].my_include?('b')).to eq(true)
    expect(%w[a b c d].my_include?('2')).to eq(false)
  end
end
