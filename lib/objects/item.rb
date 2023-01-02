require_relative "./object"

class Item < DObject
    attr_accessor :tags

    def initialize(name = "unidentifiable item", desc = "This seems like an item", type = "mundane", faction = "none")
        super
        @commands << "TAKE"
        @tags = []
    end
end

