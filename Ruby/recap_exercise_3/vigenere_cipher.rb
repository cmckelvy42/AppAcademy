def vigenere_cipher(message, keys)
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    ret = ""
    i = 0
    message.each_char do |c|
        ret << alphabet[(alphabet.index(c) + keys[i]) % 26]
        i = i + 1 == keys.size ? 0 : i + 1
    end
    return ret
end

p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
p vigenere_cipher("yawn", [5, 1])             # => "dbbo"