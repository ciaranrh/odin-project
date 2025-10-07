class Gameboard
  # This is a CLASS CONSTANT
  POSITION_MAP = {
    1 => [0, 0], 2 => [0, 1], 3 => [0, 2],
    4 => [1, 0], 5 => [1, 1], 6 => [1, 2],
    7 => [2, 0], 8 => [2, 1], 9 => [2, 2]
  }.freeze

  def initialize
    # 0 = O, 1 = X and everything else = ' '
    @board = [[2, 3, 4], [5, 6, 7], [8, 9, 10]]
    @won = false
    @turn_count = 1
    @p_choice = [2, 2] # [0] = P1, [1] = P2
  end
  attr_accessor :board, :won, :turn_count

  def show_board
    puts 'Current board:'
    (0..2).each do |row|
      (0..2).each do |col|
        # Print the symbol
        case board[row][col]
        when 0
          print ' O '
        when 1
          print ' X '
        else
          print '   '
        end
        print '|' if col < 2
      end
      puts
      puts '-----------' if row < 2
    end
    puts
  end

  def show_reference_board
    puts 'Position reference:'
    puts ' 1 | 2 | 3 '
    puts '-----------'
    puts ' 4 | 5 | 6 '
    puts '-----------'
    puts ' 7 | 8 | 9 '
  end

  def coordinates(position)
    POSITION_MAP[position]
  end

  def choice(input)
    @p_choice[0] = input
    @p_choice[1] = (input.zero? ? 1 : 0)
  end

  def player_choice
    valid = false
    puts 'Hello Player 1, select:'
    while valid == false
      print '0 for O or 1 for X: '
      input = gets.chomp.to_i
      if [0, 1].include?(input)
        choice(input)
        valid = true
      else
        puts 'Invalid selection'
      end
    end
  end

  def current_player
    cur_player = 1
    cur_player = 2 if turn_count.even?
    cur_player
  end

  def valid_position(cur_player)
    valid = false
    while valid == false
      show_reference_board
      cur_sel = (@p_choice[(cur_player - 1)].zero? ? 'O' : 'X')
      print "Player #{cur_player} (#{cur_sel}) - Input selection: "

      pos = gets.chomp.to_i
      if (pos < 1) || (pos > 9)
        puts 'Invalid selection, select 1 - 9'
        next
      end

      coords = coordinates(pos)
      if coords
        row, col = coords
        if board[row][col].zero? || (board[row][col] == 1)
          puts 'Space already occupied! Select another'
          show_board
        else
          valid = true
        end
      end
      puts ''
    end
    [row, col]
  end

  def place_move(position, cur_player)
    board[position[0]][position[1]] = @p_choice[(cur_player - 1)]
    puts 'Move placed'
    puts ''
  end

  def input
    # Player 1 to choose X or O; all subsequent moves will be referenced against turn_count and p1_choice
    player_choice if @turn_count == 1

    cur_player = current_player
    position = valid_position(cur_player)
    place_move(position, cur_player)

    @turn_count += 1

    cur_player
  end

  def start
    while @won == false
      show_board
      cur_player = input

      check_win(cur_player) if @turn_count >= 4
    end
  end

  def win(cur_player)
    show_board
    puts "Player #{cur_player} - You win!"
    @won = true
  end

  def check_win(cur_player)
    # check each row and columns for consecutives
    (0..2).each do |i|
      if board[i].uniq.one?
        win(cur_player)
        return
      end
      if board.transpose[i].uniq.one?
        win(cur_player)
        return
      end
    end
    # check diagonals
    if [board[0][0], board[1][1], board[2][2]].uniq.one?
      win(cur_player)
      return
    end
    return unless [board[0][2], board[1][1], board[2][0]].uniq.one?

    win(cur_player)
    nil
  end
end
