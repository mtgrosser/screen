class ScreenShot
  attr_reader :display
  
  def initialize(display)
    @display = display.to_i
    raise ArgumentError, 'illegal DISPLAY' if @display < 0 || @display > 99
  end
  
  def response
    [
      200,
      { 'Content-Type' => 'image/png' },
      IO.popen("convert xwd:/run/xvfb/#{display}/Xvfb_screen0 png:-") { |io| io.binmode; io.read }
    ]
  end
end

class ScreenShotApp
  def self.call(env)
    request = Rack::Request.new(env)
    ScreenShot.new(request.params['display']).response
  end
end

run ScreenShotApp
