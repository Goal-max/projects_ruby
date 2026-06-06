require 'debug'
def bubble_sort (data)
   sort(data)
end

def sort (array)
  sorted = array
  sorted_status = 0
  sorted.each_index do |index|
    break if index == sorted.length - 1
    #binding.break
    next if sorted[index] <= sorted[index + 1]
    large_num = sorted[index]
    small_num = sorted[index + 1]
    sorted[index] = small_num
    sorted[index + 1] = large_num 
    sorted_status += 1
  end
  if sorted_status > 0
    sorted_status = 0
    sort(sorted)
  end
  sorted
end

#tests
list = [4, 3, 78, 2, 0, 2]
if bubble_sort(list) == [0, 2, 2, 3, 4, 78]
  puts 'passed'
else
  puts 'failed'
end

