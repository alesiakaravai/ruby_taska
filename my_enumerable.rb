# frozen_string_literal: true

module MyEnumerable
  def my_reject
    if block_given?
      elements = []
      each { |x| elements << x unless yield(x) }
      elements
    else
      to_enum(:my_reject)
    end
  end

  def my_any?(value = nil)
    if !value.nil?
      each { |x| return true if value === x }
    elsif block_given?
      each { |x| return true if yield(x) }
    else
      each { |x| return true if x }
    end
    false
  end

  def my_all?(value = nil)
    if !value.nil?
      each { |x| return false unless value === x }
    elsif block_given?
      each { |x| return false unless yield(x) }
    else
      each { |x| return false unless x }
    end
    true
  end

  def my_none?(value = nil)
    if block_given?
      each { |x| return false if yield(x) }
    elsif !value.nil?
      each { |x| return false if value === x }
    else
      each { |x| return false if x }
    end
    true
  end

  def my_min(value = nil)
     if value.nil?
       min_value = self[0]
       each { |i| min_value = i if min_value > i }
       min_value
     else
       arr = self
       (0...value).map {
         arr.my_min
         arr.delete(arr.my_min) }
     end
  end

  def my_max
    if value.nil?
      max_value = self[0]
      each { |i| max_value = i if max_value < i }
      max_value
    else
      arr = self
      (0...value).map {
        arr.my_max
        arr.delete(arr.my_max) }
    end
  end

  def my_find_index(value = nil)
    if !value.nil?
      (0..size).each { |x| return x if self[x] == value}
    elsif block_given?
      (0..size).each { |x| return x if yield(self[x])}
    else 
      return to_enum(:my_find_index)
    end
    nil
  end

  def my_find(if_none_proc = nil)
    to_enum(:my_find) if !block_given?

    each {|x| return x if yield(x)}
    if_none_proc.nil? ? nil : if_none_proc.call
  end

  def my_find_all(value = nil)
    elements = []
    if !value.nil?
      each {|x| elements << x if x == value}
    elsif block_given?
      each {|x| elements << x if yield(x)}
    end
    elements
  end

  def my_select
    to_enum(:my_select) if !block_given?
    elements = []
    each { |x| elements << x if yield(x) }
    elements
  end

  def my_count(value = nil)
    count = 0
    
    if !value.nil?
      each {|x| count += 1 if value == x}
    elsif block_given?
      each {|x| count += 1 if yield(x)}
    else
      count = length
    end
    count
  end

  def my_map
    if block_given?
      elements = []
      each {|x| elements << yield(x)}
      return elements
    end
    self
  end

  def my_include?(value)
    each {|x| return true if value == x}
    false
  end
end

class Array
  include MyEnumerable
end
