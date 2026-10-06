require 'ostruct'

class Coordinates < OpenStruct; end

class Grid
  attr_reader :height, :width, :canvas, :context, :max_x, :max_y

  CELL_HEIGHT = 15;
  CELL_WIDTH  = 15;

  def initialize
    @canvas  = `document.getElementById(#{canvas_id})`
    @context = `#{canvas}.getContext('2d')`
    @width   = `$("#gridContainer").width()`
    @height  = `#{canvas}.height`
    @max_x   = [((width - 1) / CELL_WIDTH).floor, 1].max
    @max_y   = [((height - 1) / CELL_HEIGHT).floor, 1].max
    @width   = max_x * CELL_WIDTH + 1
    @height  = max_y * CELL_HEIGHT + 1
    draw_grid
  end

  def draw_grid
    `#{canvas}.width  = #{width}`
    `#{canvas}.height = #{height}`

    x = 0.5
    until x >= width do
      `#{context}.moveTo(#{x}, 0)`
      `#{context}.lineTo(#{x}, #{height})`
      x += CELL_WIDTH
    end

    y = 0.5
    until y >= height do
      `#{context}.moveTo(0, #{y})`
      `#{context}.lineTo(#{width}, #{y})`
      y += CELL_HEIGHT
    end

    `#{context}.strokeStyle = "#bbb"`
    `#{context}.stroke()`
  end


  def redraw_canvas(s)
    s.each_with_index do |row, x|
      row.each_with_index do |cell, y|
        if cell == 1
          fill_cell(x, y)
        else
          unfill_cell(x, y)
        end
      end
    end
  end
  
  def get_cursor_position(event)
    bounds = `#{canvas}.getBoundingClientRect()`
    x = (event[:clientX] - `#{bounds}.left`) * width / `#{bounds}.width`
    y = (event[:clientY] - `#{bounds}.top`) * height / `#{bounds}.height`

    x = (x / CELL_WIDTH).floor
    y = (y / CELL_HEIGHT).floor

    Coordinates.new(x: x, y: y)
  end

  def fill_cell(x, y)
    x *= CELL_WIDTH;
    y *= CELL_HEIGHT;
    `#{context}.fillStyle = "#fff"`
    `#{context}.fillRect(#{x.floor+1}, #{y.floor+1}, #{CELL_WIDTH-1}, #{CELL_HEIGHT-1})`
  end

  def unfill_cell(x, y)
    x *= CELL_WIDTH;
    y *= CELL_HEIGHT;
    `#{context}.clearRect(#{x.floor+1}, #{y.floor+1}, #{CELL_WIDTH-1}, #{CELL_HEIGHT-1})`
  end

  def canvas_id
    'gameCanvas'
  end

  def add_mouse_event_listener
    { click: 1, dblclick: 0 }.each do |event_name, state|
      Element.find("##{canvas_id}").on event_name do |event|
        coords = get_cursor_position(event)
        yield coords.x, coords.y, state
      end
    end
  end
end
