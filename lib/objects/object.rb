class Object
    attr_accessor :commands

    def initialize
        @commands = ["inspect"]
        @description = "This seems like an object"
    end

    def inspect
        @description
    end
end