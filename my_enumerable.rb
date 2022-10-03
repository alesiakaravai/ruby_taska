# frozen_string_literal: true

# all? any? include? none? each map! map size count
# length select find reject

module MyEnurmerable
  def my_inject(value = nil)
    result = value.nil? ? 0 : value
    i = 0
    while i < size
      result = yield(result, self[i])
      i += 1
    end
    result
  end

  def my_min
    min_el = self[0]
    i = 1
    while i < size
      min_el = self[i] if min_el > self[i]
      i += 1
    end
    min_el
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

  def my_find_index(value = nil)  # доделать с мэпами && give last elem
    index
    i = 0
    if !value.nil?
      while i < size
        index = i if self[i] == value
        i += 1
      end
    elsif block_given?
      while i < size
        index = i if yield(self[i])
        i += 1
      end
    end
    index
  end

  def my_find_all(value = nil)
    index = []
    i = 0
    if !value.nil?
      while i < size
        index.push(self[i]) if self[i] == value
        i += 1
      end
    elsif block_given?
      while i < size
        index.push(self[i]) if yield(self[i])
        i += 1
      end
    end
    index
  end
end

class Array
  include MyEnurmerable
end
