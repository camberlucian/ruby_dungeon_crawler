class String
    def initial
      self[0,1]
    end
end

def add_article(item)
    vowels = ["a", "e", "i", "o", "u"]
    if vowels.include?(item.initial.downcase)
        "an #{item}"
    else
        "a #{item}"
    end
end