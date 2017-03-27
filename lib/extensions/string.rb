class String
  def inet_atoi
    quads = self.split('.')
    as_int = nil
    if quads.length == 4
      as_int = (quads[0].to_i * (2**24)) + (quads[1].to_i * (2**16)) + (quads[2].to_i * (2**8)) + quads[3].to_i
      as_int -= 4_294_967_296 if as_int > 2147483647 # Convert to 2's complement
    end
    as_int
  end
end