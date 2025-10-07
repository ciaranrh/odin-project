class Gameboard
  # This is a CLASS CONSTANT
  POSITION_MAP = {
    1 => [0, 0], 2 => [0, 1], 3 => [0, 2],
    4 => [1, 0], 5 => [1, 1], 6 => [1, 2],
    7 => [2, 0], 8 => [2, 1], 9 => [2, 2]
  }

  def initialize()
    #0 = O, 1 = X and everything else = ' '
    @board = [[2, 3, 4], [5, 6, 7], [8, 9, 10]]
    @won = false
    @turn_count = 1
    @p_choice = [2,2] # [0] = P1, [1] = P2
  end
  attr_accessor :board, :won, :turn_count
 
  def show_board()
    puts "Current board:"
    for row in 0..2
      for col in 0..2
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
    puts "Position reference:"
    puts " 1 | 2 | 3 "
    puts "-----------"
    puts " 4 | 5 | 6 "
    puts "-----------"
    puts " 7 | 8 | 9 "
  end

  def get_coordinates(position)
    POSITION_MAP[position]
  end

  def set_choice(input)
    @p_choice[0] = input
    @p_choice[1] = (input == 0 ? 1 : 0)
  end

  def get_player_choice
    valid = false
    puts "Hello Player 1, select:"
    while valid == false
      print "0 for O or 1 for X: "
      input = gets.chomp.to_i
      if input == 0 || input == 1
        set_choice(input)
        valid = true
      else
        puts "Invalid selection"
      end
    end
  end

  def get_current_player
    cur_player = 1
    if (turn_count % 2) == 0
      cur_player = 2
    end
    cur_player
  end

  def get_valid_position(cur_player)
    valid = false
    while valid == false
      self.show_reference_board
      cur_sel = (@p_choice[(cur_player-1)] == 0? 'O' : 'X')
      print "Player #{cur_player} (#{cur_sel}) - Input selection: "

      pos = gets.chomp.to_i
      if (pos < 1) or (pos > 9)
        puts "Invalid selection, select 1 - 9"
        next
      end 

      coords = self.get_coordinates(pos)
      if coords
        row, col = coords
        if (self.board[row][col] == 0) or (self.board[row][col] == 1)
          puts "Space already occupied! Select another"
          self.show_board
        else
          valid = true
        end
      end
      puts ""
    end
    [row, col]
  end

  def place_move(position, cur_player)
    self.board[position[0]][position[1]] = @p_choice[(cur_player-1)]
    puts "Move placed"
    puts ""
  end

  def get_input()
    # First move only, ask player 1 to choose X or O; all subsequent moves will be referenced against turn_count and p1_choice
    if @turn_count == 1
      get_player_choice  
    end
    
    cur_player = get_current_player
    position = get_valid_position (cur_player) 
    place_move(position, cur_player)  
    
    @turn_count += 1

    cur_player
  end

  def start
    while @won == false
      show_board
      cur_player = get_input
      
      if @turn_count >= 4
        check_win(cur_player)
      end
    end
  end

  def win(cur_player)
    show_board  
    puts "Player #{cur_player} - You win!"
    @won = true
  end

  def check_win(cur_player)
    #check each row and columns for consecutives
    for i in 0..2
      if self.board[i].uniq.count == 1
        win(cur_player)
        return
      end
      if self.board.transpose[i].uniq.count == 1
        win(cur_player)
        return
      end
    end
    #check diagonals
    if [self.board[0][0],self.board[1][1],self.board[2][2]].uniq.count == 1
      win(cur_player)
      return
    end
    if [self.board[0][2],self.board[1][1],self.board[2][0]].uniq.count == 1
      win(cur_player)
      return
    end
  end
end