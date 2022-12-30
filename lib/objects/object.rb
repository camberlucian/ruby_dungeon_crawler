class DObject
    attr_accessor :commands
    attr_accessor :object_type

    def initialize(name = "unidentifiable object", desc = "This seems like an object", type = "mundane",)
        @commands = ["QUIT", "EXAMINE"]
        @description = desc
        @name = name
        @object_type = type
    end

    def examine
        @description
    end
end