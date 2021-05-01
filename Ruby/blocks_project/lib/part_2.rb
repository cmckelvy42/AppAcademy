def all_words_capitalized?(words)
    return words.all?{|w| w.capitalize == w}
end

def no_valid_url?(arr)
    valid_ends = ['.com', '.net', '.io','.org']
    arr.none? {|url| valid_ends.any?{|ending| url.end_with?(ending)}}
end

def any_passing_students?(students)
    return students.any? {|s| s[:grades].sum / (s[:grades].size) >= 75}
end