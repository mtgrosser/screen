class ScreenShot
  def response
    [
      200,
      { 'Content-Type' => 'image/png' },
      IO.popen('convert /var/lib/xvfb/Xvfb_screen0 png:-') { |io| io.binmode; io.read }
    ]
  end
end

class ScreenShotApp
  def self.call(env)
    ScreenShot.new.response
  end
end

run ScreenShotApp
