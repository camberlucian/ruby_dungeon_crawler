def add_article(item)
    vowels = ["a", "e", "i", "o", "u"]
    if vowels.include?(item.initial)
        "an #{item}"
    else
        "a #{item}"
    end
end