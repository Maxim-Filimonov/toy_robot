class FakeDisplay
  def initialize
    @buffer = []
  end

  def puts(msg)
    @buffer << msg
  end

  def gets
    @buffer.last
  end
end
