require 'ostruct'

class Coordinates < OpenStruct; end

class Grid
  attr_reader :height, :width, :canvas, :context, :max_x, :max_y
  attr_accessor :seed

  CELL_HEIGHT = 15;
  CELL_WIDTH  = 15;

  def initialize
    @height  = `$("#gridContainer").height()`
    @width   = `$("#gridContainer").width()`
    @canvas  = `document.getElementById(#{canvas_id})` 
    @context = `#{canvas}.getContext('2d')`
    @max_x   = (width / CELL_WIDTH).floor
    @max_y   = (height / CELL_HEIGHT).floor
    @seed    = []
    draw_grid
    add_mouse_event_listener
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

    `#{context}.strokeStyle = "#eee"`
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
    if (event.page_x && event.page_y)
      x = event.page_x;
      y = event.page_y;
    else
      doc = Opal.Document[0]
      x = event[:clientX] + doc.scrollLeft + doc.documentElement.scrollLeft;
      y = event[:clientY] + doc.body.scrollTop + doc.documentElement.scrollTop;
    end

    x -= `#{canvas}.offsetLeft`
    y -= `#{canvas}.offsetTop`
   
    x = (x / CELL_WIDTH).floor
    y = (y / CELL_HEIGHT).floor

    Coordinates.new(x: x, y: y)
  end

  def fill_cell(x, y)
    x *= CELL_WIDTH;
    y *= CELL_HEIGHT;
    `#{context}.fillStyle = "#000"`
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
    Element.find("##{canvas_id}").on :click do |event|
      coords = get_cursor_position(event)
      x, y   = coords.x, coords.y
      fill_cell(x, y)
      seed.push([x, y])
    end

    Element.find("##{canvas_id}").on :dblclick do |event|
      coords = get_cursor_position(event)
      x, y   = coords.x, coords.y
      unfill_cell(x, y)
      seed.delete([x, y])
    end
  end
end
