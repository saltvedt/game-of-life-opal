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
    add_button_event_listener
  end

  def add_button_event_listener
    Element.find("#start_stop").on :click do |event|
      start_stop
    end
  end

  def start_stop
    if @interval.nil?
      load_seed
      run
    elsif @interval.running?
      @interval.stop
    else
      @interval.resume
    end
  end

  def blank_state
    Array.new(grid.max_x) { Array.new(grid.max_y) { 0 } }
  end

  def get_state(x, y)
    state[x % grid.max_x][y % grid.max_y]
  end

  def set_state(x, y, s)
    state[x][y] = s
  end

  def load_seed
    grid.seed.each do |x, y|
      set_state(x, y, 1)
    end
    grid.seed = []
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