# xor

Simple XOR for encryption / decryption example(s). Not for production.

In cryptography, the simple XOR cipher is a type of additive cipher. This operation is sometimes called modulus 2 addition (or subtraction, which is identical). With this logic, a string of text can be encrypted by applying the bitwise XOR operator to every character using a given key. To decrypt the output, merely reapplying the XOR function with the key will remove the cipher. - wikipedia XOR_ciper

## BackGround

***By itself, using a constant repeating key, a simple XOR cipher can trivially be broken using frequency analysis***

Reusing the same key multiple times is called giving the encryption 'depth' - and it is intuitive that the more depth given, the more likely it is that information about the plaintext is contained within the encrypted text.

https://crypto.stackexchange.com/questions/59/taking-advantage-of-one-time-pad-key-reuse/108#108

### Malware 

The XOR cipher is often used in computer malware to make reverse engineering more difficult

