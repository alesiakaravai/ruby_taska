# frozen_string_literal: true

require_relative './my_enumerable'

array1 = [100, 5, 3]
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

# p array2.my_count{ |value| value % 1 == 0}

#p array1.my_any?(5)


enum = Enumerator. new {|y| array1.each {|x| y << x}}

#p enum

p array1.my_reject
#p enum



