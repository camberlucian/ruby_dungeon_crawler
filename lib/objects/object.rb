class DObject
    attr_accessor :commands

    def initialize
        @commands = ["QUIT", "EXAMINE"]
        @description = "This seems like an object"
    end

    def examine
        @description
    end
end