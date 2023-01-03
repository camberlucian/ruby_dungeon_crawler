require_relative "./object"

class Item < DObject
    attr_accessor :tags
    attr_accessor :location

    def initialize(name = "unidentifiable item", desc = "", type = "mundane", faction = "none", location = "room")
        super(name, desc, type, faction)
        @commands << "TAKE"
        @location = location
        @tags = []
    end
end

