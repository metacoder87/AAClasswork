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

  attr_reader :cursor_pos, :board, :selected, :helper

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @selected = []
    @board = board
    @helper = false
  end

  def toggle_selected
    if @selected.count == 1 && @selected[0] != @cursor_pos
      @selected << @cursor_pos
      board.move_piece(@selected[0],@selected[1])
      return @selected.clear
    elsif @selected.count == 0
      @selected << @cursor_pos
    elsif @selected.count == 1 && @selected[0] == @cursor_pos
      @selected.clear
    end
  end

  def toggle_helper
    if @helper == false && @selected.first
        @helper = true
        x, y = @selected[0]
        return
    end 
    return @helper = false
  end

  def get_input
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
    case key
    when :return, :space
        toggle_selected
    when :left, :right, :up, :down
        update_pos(MOVES[key])
    when :ctrl_c
        Process.exit!(0)
    when :tab
        toggle_helper
    end
  end

  def update_pos(diff)
    x1, y1 = @cursor_pos
    x2, y2 = diff
    x = x1 + x2
    y = y1 + y2
    @cursor_pos = [x, y] if board.valid_pos([x,y])    
  end
  
end