require_relative "../tables/dungeon_tables"
require_relative "./container"

class Room < Container
    attr_accessor :type

    def initialize(type, entrance = false)
        super()
        @commands << "ONWARD"
        if !entrance
            @commands << "BACKWARD"
        end
        @type = type
        @description = "You find yourself in a #{@type.upcase}."
    end

    def get_commands()
        @commands
    end
end