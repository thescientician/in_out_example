class Fixnum
  def inet_itoa
    value = self
    return nil unless value
    value += 4_294_967_296 if value < 0 # Convert from 2's complement
    "#{(value & 0xFF000000) >> 24}.#{(value & 0x00FF0000) >> 16}.#{(value & 0x0000FF00) >> 8}.#{value & 0x000000FF}"
  end
end