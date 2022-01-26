# XOR Cipher - Ruby

This uses the `.pack(C*)` method to handle unprintable characters, and loops the key to create a onetime pad big enough to match the message length

## Usage

```ruby
require './decrypt.rb'
msg = 'attack at dawn'
key = 'foobar'

a = Decrypt.xor msg, key
# => "\a\e\e\x03\x02\x19F\x0E\eB\x05\x13\x11\x01"
Decrypt.xor a, key
# => "attack at dawn"
```

### Cycle Proof

```ruby
Decrypt.xor (Decrypt.xor "attack at dawn", "foobar"), "foobar"
# => "attack at dawn"
```
