require_relative "../tables/dungeon_tables"

class Room < Container
    attr_accessor :type

    def initialize(creator, function, entrance = false)
        @type = get_room_type(creator, function)
    end

    def get_room_type()
        possible_types = get_room_types(creator, function)
    end
end