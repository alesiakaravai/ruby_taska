# frozen_string_literal: true

module MyEnumerable
  def my_reject
    if block_given?
      array = []
      each { |element| array << element unless yield(element) }
      array
    else
      to_enum(:my_reject)
    end
  end

  def my_any?(pattern = nil)
    if !pattern.nil?
      warn('given block not used', uplevel: 1) if block_given?
      each { |element| return true if pattern === element }
    elsif block_given?
      each { |element| return true if yield(element) }
    else
      each { |element| return true if element }
    end
    false
  end

  def my_all?(pattern = nil)
    if !pattern.nil?
      warn('given block not used', uplevel: 1) if block_given?
      each { |element| return false unless pattern === element }
    elsif block_given?
      each { |element| return false unless yield(element) }
    else
      each { |element| return false unless element }
    end
    true
  end

  def my_none?(pattern = nil)
    if !pattern.nil?
      warn('given block not used', uplevel: 1) if block_given?
      each { |element| return false if pattern === element }
    elsif block_given?
      each { |element| return false if yield(element) }
    else
      each { |element| return false if element }
    end
    true
  end

  def my_min(element = nil, &block)
    if element.nil?
      min_element = self[0]
      if block_given?
        each { |i| min_element = i if yield(i, min_element).negative? }
      else
        each { |i| min_element = i if min_element > i }
      end
      min_element
    else
      array = self
      return array if array.empty?

      (0...element).map do
        min_element = array.my_min(&block)
        array.delete(min_element)
      end
    end
  end

  def my_max(element = nil, &block)
    if element.nil?
      max_element = self[0]
      if block_given?
        each { |i| max_element = i if yield(i, max_element).positive? }
      else
        each { |i| max_element = i if max_element < i }
      end
      max_element
    else
      array = self
      return array if array.empty?

      (0...element).map do
        max_element = array.my_max(&block)
        array.delete(max_element)
      end
    end
  end

  def my_find_index(object = nil)
    if !object.nil?
      warn('given block not used', uplevel: 1) if block_given?
      (0..size).each { |x| return x if self[x] == object }
    elsif block_given?
      (0..size).each { |x| return x if yield(self[x]) }
    else
      return to_enum(:my_find_index)
    end
    nil
  end

  def my_find(if_none_proc = nil)
    return to_enum(:my_find) if !block_given? && if_none_proc.nil?
    return to_enum(:my_find, if_none_proc) if !block_given? && !if_none_proc.nil?

    each { |element| return element if yield(element) }
    if_none_proc.nil? ? nil : if_none_proc.call
  end

  def my_find_all
    return to_enum(:my_find_all) unless block_given?

    array = []
    each { |x| array << x if yield(x) }
    array
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    array = []
    each { |x| array << x if yield(x) }
    array
  end

  def my_count(object = nil)
    count = 0

    if !object.nil?
      warn('given block not used', uplevel: 1) if block_given?
      each { |element| count += 1 if object == element }
    elsif block_given?
      each { |element| count += 1 if yield(element) }
    else
      count = length
    end
    count
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    array = []
    each { |x| array << yield(x) }
    array
  end

  def my_include?(object)
    each { |element| return true if object == element }
    false
  end
end

class Array
  include MyEnumerable
end
