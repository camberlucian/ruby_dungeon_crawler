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

def concat_list(list)
    text = ""
    if list.size > 1
        for a in 0..list.size-2 do
            name = list[a].name.upcase
            text += add_article(name) + ", "
        end
        name = list.last.name.upcase
        text += "and " + add_article(name) + "."
    else
        name = list.last.name.upcase
        text += add_article(name) + "."
    end
    text
end