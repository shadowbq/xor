module Decrypt

  def self.xor(msg, key)
    key_wrap = key
    key_wrap << key while key.length < msg.length

    if key_wrap.length > msg.length
      key_trunc = key_wrap.to_s[0...msg.length] 
    else
      key_trunc = key_wrap
    end

    msg = msg.unpack('C*')
    d_key = key_trunc.unpack('C*')
    xor = []

    (0...msg.length).each do |i|
      xor.push msg[i] ^ d_key[i]
    end
    xor = xor.pack('C*')

    xor
  end

end