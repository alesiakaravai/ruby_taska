# frozen_string_literal: true

module MyEnurmerable
  def my_reject
    if block_given?
      elements = []
      each { |x| elements << x unless yield(x) }
      elements
    else
      Enumerator.new { |y| each { |x| y << x } } # здесь должен "<Enumerator: [array]:reject>", но не знаю как
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

  # доделать
  def my_inject(value = nil)
    result = value.nil? ? 0 : value
    i = 0
    while i < size
      result = yield(result, self[i])
      i += 1
    end
    result
  end

  def my_min(value = nil)
    unless value.nil?
      array = []
      # each { |x| }  #####
      min = self[0]
      each { |x| min = x if min > x }
      min
    end
  end

  def my_max
    max_el = self[0]
    i = 1
    while i < size
      max_el = self[i] if max_el < self[i]
      i += 1
    end
    max_el
  end

  def my_find_index(value = nil)
    index
    i = 0
    if !value.nil?
      while i < size
        if self[i] == value
          index = i
          break
        end
        i += 1
      end
    elsif block_given?
      while i < size
        if yield(self[i])
          index = i
          break
        end
        i += 1
      end
    end
    index
  end

  def my_find(if_none_proc = nil)
    i = 0
    if block_given?
      while i < size
        return self[i] if yield(self[i])

        i += 1
      end
    end
    return false if if_none_proc.nil?

    if_none_proc
  end

  def my_find_all(value = nil)
    elements = []
    i = 0
    if !value.nil?
      while i < size
        elements.push(self[i]) if self[i] == value
        i += 1
      end
    elsif block_given?
      while i < size
        elements.push(self[i]) if yield(self[i])
        i += 1
      end
    end
    elements
  end

  def my_select
    elements = []
    i = 0
    while i < size
      elements.push(self[i]) if yield(self[i])
      i += 1
    end
    elements
  end

  def my_count(value = nil)
    count = 0
    i = 0
    if !value.nil?
      while i < size
        count += 1 if value == self[i]
        i += 1
      end
    elsif block_given?
      while i < size
        count += 1 if yield(self[i])
        i += 1
      end
    else
      count = length
    end
    count
  end

  def my_map
    if block_given?
      elements = []
      i = 0
      while i < size
        elements.push(yield(self[i]))
        i += 1
      end
      return elements
    end
    self
  end

  def my_include?(value)
    i = 0
    while i < size
      return true if value == self[i]

      i += 1
    end
    false
  end
end

class Array
  include MyEnurmerable
end
