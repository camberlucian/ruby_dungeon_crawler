require_relative "../helpers"

class DObject
    attr_accessor :commands
    attr_accessor :object_type
    attr_accessor :faction
    attr_accessor :name

    def initialize(name = "unidentifiable object", desc = "", type = "mundane", faction = "none")
        @commands = ["QUIT", "EXAMINE"]
        @description = "It is #{add_article(name).upcase}. " + desc
        @name = name
        @object_type = type
        @faction = faction
    end

    def examine
        @description
    end
end