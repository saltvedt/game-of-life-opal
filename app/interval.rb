class Interval
  def initialize(ticker, time = 0)
    @time = time
    @ticker = ticker
  end

  def resume
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