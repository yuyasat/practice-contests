# n本の棒があります。棒iの長さはaiです。あなたは、それらの棒から3本選んでできるだけ周辺の長い
# 三角形を作ろうと考えています。最大の周長を求めなさい。ただし、三角形が作れない際には0を答え
# としなさい。
# 制約：
# 3 <= n <= 100
# 1 <= ai <= 10^6

def main
  array = ARGV[0..-1].map(&:to_i)

  judge = nil
  valid_comb = array.combination(3).select { |i, j, k|
    max = [i, j, k].max
    max < i + j + k - max
  }
  if valid_comb.empty?
    puts 0
  else
    puts valid_comb.max { |ar| ar.sum }.sum
  end
end

main

def with_loop
  array = ARGV[0..-1].map(&:to_i)

  ans = 0

  array.each_with_index { |i, i1|
    array[i1 + 1..-1].each_with_index { |j, j1|
      array[i1 + 1..-1][j1 + 1..-1].each { |k|
        len = i + j + k
        max = [i, j, k].max
        rest = len - max
        ans = [ans, len].max if (max < rest) if (max < rest)
      }
    }
  }

  puts ans
end

with_loop
