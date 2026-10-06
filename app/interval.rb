class Interval
  def initialize(ticker, time = 100)
    @time = time
    @ticker = ticker
  end

  def resume
    return if running?

    @interval = `setInterval(function(){#{@ticker.call}}, #{@time})`
  end
  alias :start :resume

  def stop
    `clearInterval(#{@interval})`
    @interval = nil
  end

  def running?
    !@interval.nil?
  end
end