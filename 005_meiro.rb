# 大きさがNxMの迷路がある。迷路は通路と壁からできており、１ターンに隣接する上下左右４マスの
# 通路へ移動することができる。スタートからゴールまで移動するのに必要な最小のターン数を求めよ。
# ただし、スタートからゴールまでは必ず移動できるものとする。
# 制約
# N, M <= 100

FIELD = [
  %w(# S # # # # # # . #),
  %w(. . . . . . # . . #),
  %w(. # . # # . # # . #),
  %w(. # . . . . . . . .),
  %w(# # . # # . # # # #),
  %w(. . . . # . . . . #),
  %w(. # # # # # # # . #),
  %w(. . . . # . . . . .),
  %w(. # # # # . # # # .),
  %w(. . . . # . . . G #),
]

def bfs
  d = [].tap { |a|
    FIELD.length.times { a << ([nil]*FIELD[0].length).dup }
  }
  start_i = FIELD.index { |row| row.any? { |f| f == "S" } }
  start_j = FIELD.find { |row| row.any? { |f| f == "S" } }.index { |f| f == "S" }

  goal_i = FIELD.index { |row| row.any? { |f| f == "G" } }
  goal_j = FIELD.find { |row| row.any? { |f| f == "G" } }.index { |f| f == "G" }

  # 下 左 上 右
  # di = [1, 0, -1, 0]
  # dj = [0, -1, 0, 1]

  # 右 上 左 下
  di = [0, -1, 0, 1]
  dj = [1, 0, -1, 0]

  que = []
  que.push({ i: start_i, j: start_j })
  d[start_i][start_j] = 0

  cnt = 0

  while (que.size > 0) do
    p = que.pop
    break if p[:i] == goal_i && p[:j] == goal_j

    [0, 1, 2, 3].each do |k|
      ni = p[:i] + di[k]
      nj = p[:j] + dj[k]

      cnt = cnt + 1
      if 0 <= ni && ni < FIELD.length && 0 <= nj && nj < FIELD[0].length
        if FIELD[ni][nj] != '#' && d[ni][nj].nil?
          que.push({ i: ni, j: nj })
          d[ni][nj] = d[p[:i]][p[:j]] + 1
        end
      end
    end
    d.each_with_index { |a, i|
      puts a.map.with_index { |b, j|
        b.nil? ?
          FIELD[i][j] == '#' ? ' #' : '  '
        : sprintf("%02d", b)
      }.join(" ")
    }
    puts "="*30
  end

  puts "cnt:#{cnt}"
  puts d[goal_i][goal_j]
end

bfs
