class String
    def select(&prc)
        ret = ""
        return ret if !prc
        self.each_char{|c| ret << c if prc.call(c)}
        return ret
    end
end

p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
p "HELLOworld".select          # => ""