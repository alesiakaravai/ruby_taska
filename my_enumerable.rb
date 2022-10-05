# frozen_string_literal: true

# each - какой именно?

# map! - не нашла

# Вот эти могу написать, но есть ли разница между нимим?
# size - не нашла
# length - не нашла

module MyEnurmerable
  def my_reject
    elements
    i = 0
    if block_given?
      while i < size
        elements.push(yield(self[i]))
        i += 1
      end
      elements
    else
      return self
    end
  end

  def my_any?(value = nil)
    i = 0
    if !value.nil?
      while i < size
        return true if self[i] === value # ???

        i += 1
      end
    elsif block_given?
      while i < size
        return true if yield(self[i])

        i += 1
      end
    else
      while i < size
        return true if self[i]

        i += 1
      end
    end
    false
  end

  def my_all?(value = nil)
    i = 0
    if !value.nil?
      while i < size
        return false unless self[i] === value # ???

        i += 1
      end
    elsif block_given?
      while i < size
        return false unless yield(self[i])

        i += 1
      end
    else
      while i < size
        return false unless self[i]

        i += 1
      end
    end
    true
  end

  # еще не готов
  def my_none?(value = nil)
    i = 0
    if !value.nil?
      while i < size
        if value === self[i]
          return true
        else
          return false
        end

        i += 1
      end
    elsif block_given?
      if yield(self[i])
        return true
      else
        return false
      end

      i += 1
    else
      while i < size
        return false if self[i]

        i += 1
      end
    end
    true
  end

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

  # доделать с мэпами && give last elem
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
