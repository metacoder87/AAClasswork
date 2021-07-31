require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_accessor :cursor_pos, :board, :selected, :helper, :number_of_white_moves, :number_of_black_moves

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos # Location of the cursor on the Board
    @selected = [] # A box to keep the locations that have been selected
    @board = board # An instance of Board class will be passed in
    @helper = false # A toggle for a helper mode that is activated by using the tab key. It reveals the location of moves that won't put you in check.
    @number_of_white_moves = 0 # Counts the number of moves made for each color
    @number_of_black_moves = 0
  end

  def toggle_selected
    # Sets the first selected location equal to x,y
    x, y = @selected.first

    if @selected.count == 1 && @selected[0] != @cursor_pos && @board[x,y].valid_moves.include?(@cursor_pos)
      # Moves the piece if one is already selected and this spot isn't equal to the cursor location and it is a valid move
      @selected << @cursor_pos
      count_the_players_move
      board.move_piece(@selected[0],@selected[1])
      return @selected.clear
      # Adds a first selected piece location
    elsif @selected.count == 0
      @selected << @cursor_pos
      # Clears the selection and cancels the move if selecting the same piece twice
    elsif @selected.count == 1 && @selected[0] == @cursor_pos
      @selected.clear
    end
  end

  def count_the_players_move
    x, y = @selected.first
    # Counts the moves for each color 
    if @selected.first

      if @board[x, y].color == "white"
        @number_of_white_moves += 1

      elsif @board[x, y].color == "black"
        @number_of_black_moves += 1
      end
    end
  end

  def toggle_helper
    # Switches the helper genie on and off
    if @helper == false && @selected.first
        @helper = true
        x, y = @selected[0]
        return
    end 

    return @helper = false
  end

  def get_input # Converts the input into action
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key)
    # Takes in a key and does something cool
    case key
      # Select and unselect a piece 
    when :return, :space
        toggle_selected
        # Move around the board
    when :left, :right, :up, :down
        update_pos(MOVES[key])
        # Exit the game
    when :ctrl_c
        Process.exit!(0)
        # Turn on helper genie
    when :tab
        toggle_helper
    end
  end

  def update_pos(diff)
    # Moves the cursor position
    x1, y1 = @cursor_pos
    x2, y2 = diff
    x = x1 + x2
    y = y1 + y2
    @cursor_pos = [x, y] if board.valid_pos([x,y])    
  end
  
end