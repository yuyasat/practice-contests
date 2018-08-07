# 大きさNxMの庭がある。そこに雨が降り、水たまりができた。水たまりは８近傍で隣接している
# 場合には繋がっているとみなす。全部で幾つの水たまりがあるか。
# ただし、８近傍とは、次のWに対する*の部分をさす。
# ***
# *W*
# ***
# 制約：
# N, M <= 100

FIELD = [
  %w(W . . . . . . . . W W .),
  %w(. W W W . . . . . W W W),
  %w(. . . . W W . . . W W .),
  %w(. . . . . . . . . W W .),
  %w(. . . . . . . . . W . .),
  %w(. . W . . . . . . W . .),
  %w(. W . W . . . . . W W .),
  %w(W . W . W . . . . . W .),
  %w(. W . W . . . . . . W .),
  %w(. . W . . . . . . . W .),
]

def main
  mt = [].tap { |a|
    FIELD.length.times { a << ([nil]*FIELD[0].length).dup }
  }

  FIELD.each_with_index do |row, i|
    row.each_with_index do |field, j|
      next mt[i][j] = 0 unless field == 'W'
      [
        [i-1, j-1], [i-1, j], [i-1, j+1], [i, j-1], [i, j+1], [i+1, j-1], [i+1, j], [i+1, j+1]
      ].select { |ii, jj|
        ii >= 0 && jj >= 0 && ii < FIELD.length && jj < FIELD[0].length
      }.each { |check_i, check_j|
        if !mt[check_i][check_j].nil? && mt[check_i][check_j] != 0
          mt[i][j] = mt[check_i][check_j]
        elsif mt[i][j].nil?
          mt[i][j] = mt.flatten.compact.empty? ? 1 : mt.flatten.compact.max + 1
        end
      }
    end
  end

  puts mt.flatten.max
end

main

def dfs(x, y)
  FIELD[x][y] = '.'

  [-1, 0, 1].each { |dx|
    [-1, 0, 1].each { |dy|
      nx = x + dx
      ny = y + dy

      if 0 <= nx && nx < FIELD.length && 0 <= ny && ny < FIELD[0].length
        dfs(nx, ny) if FIELD[nx][ny] == 'W'
      end
    }
  }
end

def main2
  res = 0
  FIELD.each_with_index { |row, i|
    row.each_with_index { |field, j|
      if field == 'W'
        dfs(i, j)
        res = res + 1
      end
    }
  }
  puts res
end

main2
