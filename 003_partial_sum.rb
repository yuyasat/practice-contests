# 整数a1, a2, ..., anが与えられます。その中からいくつか選び、その和をちょうどkにすることが
# できるかを判定しなさい。
# 制約：
# 1 <= n <= 20
# -10^8 <= ai <= 10^8
# -1-^8 <= k <= 10^8

def partial_sum
  target = ARGV[0].to_i
  array = ARGV[1..-1].map(&:to_i)

  array.length.times do |i|
    array.combination(i+1).each do |ar|
      return "Yes" if ar.sum == target
    end
  end

  "No"
end

puts partial_sum

def partial_sum_with_recursive(i, sum)
  k = ARGV[0].to_i
  a = ARGV[1..-1].map(&:to_i)
  n = a.length

  return sum == k if i == n - 1
  return true if partial_sum_with_recursive(i + 1, sum)
  return true if partial_sum_with_recursive(i + 1, sum + a[i])
  false
end

puts "#{partial_sum_with_recursive(0, 0) ? 'Yes' : 'No'}"

