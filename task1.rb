# frozen_string_literal: true
 
require_relative './my_enumerable'

array1 = [100, 2, 3]
array2 = [3, 4, 5]

map1 = { foo: 0, bar: 1, baz: 0 }

def f
  yield(4)
end

def my_method
  yield if block_given?
  puts 'Привет из метода'
end

# f{|a| p "heelo world#{a}"}
# p array2.inject(1000){|sum, value| sum + value}
# p array2.my_inject{|sum, value| sum + value}

p array1.my_find_all { |value| value > 0 }
