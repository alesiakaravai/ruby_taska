# frozen_string_literal: true

require_relative './my_enumerable'

array1 = [100, 5, 3]
array2 = [3, 4, 5]

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

# p array1.my_any?(5)

#enum = Enumerator.new { |y| array1.each { |x| y << x } }

# p enum

# p array1.my_any?(Integer)

#p (1..4).my_all?
# p enum

#p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
#p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
#p %w{ant bear cat}.my_none?(/d/)                        #=> true
#p [1, 3.14, 42].my_none?(Float)                         #=> false
#p [].my_none?                                           #=> true
#p [nil].my_none?                                        #=> true
#p [nil, false].my_none?                                 #=> true
#p [nil, false, true].my_none?                           #=> false

#p array1.min(2){|a, b| a == b}

p array1.count(100){|x| x % 1 == 0}



