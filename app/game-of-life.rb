require 'opal'
require 'opal-jquery'
require 'forwardable'
require 'grid'
require 'interval'

class Game
  attr_reader :grid
  attr_accessor :state

  def initialize(grid)
    @grid  = grid
    @state = blank_state
    grid.add_mouse_event_listener { |x, y, s| set_state(x, y, s) }
    add_button_event_listener
    update_controls
  end

  def add_button_event_listener
    Element.find("#start_stop").on(:click) { start_stop }
    Element.find("#clear").on(:click) { clear }
    Element.find("#step").on(:click) { step }
  end

  def start_stop
    if @interval.nil?
      run
    elsif @interval.running?
      @interval.stop
    else
      @interval.resume
    end
    update_controls
  end

  def running?
    !@interval.nil? && @interval.running?
  end

  def update_controls
    Element.find("#start_stop").text = running? ? 'Pause' : 'Start'
    Element.find("#step").prop('disabled', running?)
  end

  def clear
    @interval.stop unless @interval.nil?
    self.state = blank_state
    grid.redraw_canvas(state)
    update_controls
  end

  def step
    tick unless running?
  end

  def load_glider
    return if grid.max_x < 3 || grid.max_y < 3

    offset_x = (grid.max_x / 2).floor - 1
    offset_y = (grid.max_y / 2).floor - 1
    [[1, 0], [2, 1], [0, 2], [1, 2], [2, 2]].each do |x, y|
      set_state(offset_x + x, offset_y + y, 1)
    end
  end

  def blank_state
    Array.new(grid.max_x) { Array.new(grid.max_y) { 0 } }
  end

  def get_state(x, y)
    state[x % grid.max_x][y % grid.max_y]
  end

  def set_state(x, y, s)
    return unless x >= 0 && y >= 0 && x < grid.max_x && y < grid.max_y

    state[x][y] = s
    s == 1 ? grid.fill_cell(x, y) : grid.unfill_cell(x, y)
  end

  def run
    ticker = Proc.new { tick }
    @interval = Interval.new(ticker)
    @interval.start
  end

  def tick
    self.state = new_state
    grid.redraw_canvas(self.state)
  end

  def new_state
    new_state = blank_state
    state.each_with_index do |row, x|
      row.each_with_index do |_, y|
        new_state[x][y] = calculate_new_state_at(x, y)
      end
    end
    return new_state
  end

  def calculate_new_state_at(x, y)
    pop = population_at(x, y)
    if is_alive?(x, y)
      if pop == 2 || pop == 3
        return 1
      end
    else
      if pop == 3
        return 1
      end
    end
    return 0
  end

  def population_at(x, y)
    get_state(x-1, y-1) +
    get_state(x-1, y  ) +
    get_state(x-1, y+1) +
    get_state(x,   y-1) +
    get_state(x,   y+1) +
    get_state(x+1, y-1) +
    get_state(x+1, y  ) +
    get_state(x+1, y+1)
  end

  def is_alive?(x, y)
    get_state(x, y) == 1
  end
end

game = Game.new(Grid.new)
game.load_glider
game.start_stop
