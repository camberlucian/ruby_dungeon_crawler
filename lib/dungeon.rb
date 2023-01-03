
require_relative "./helpers"
require_relative "./tables/dungeon_tables"
require_relative "./objects/room"

class Dungeon
    attr_accessor :rooms
    attr_accessor :entities
    attr_accessor :creator_type
    attr_accessor :age 
    attr_accessor :climate
    attr_accessor :current_occupier
    attr_accessor :current_invader
    attr_accessor :current_upstart
    attr_accessor :function
    attr_accessor :material
    attr_accessor :room_types
    attr_accessor :events



    def initialize(name)
        @rooms = []
        @entities = []
        @creator_type, @age, @climate, @current_occupier, @current_invader, @current_upstart, @function, @material, @room_types = build_dungeon(name)
        room = Room.new(@room_types.sample, true)
        @events = room.populate(@current_occupier, @current_invader, @current_upstart, @function, @events)
        @rooms[0] = room
        @events = []
    end

    def add_room()
        room = Room.new(@room_types.sample, false)
        @events = room.populate(@current_occupier, @current_invader, @current_upstart, @function, @events)
        @rooms << room
    end

    def get_interactables(location)
        contents = @rooms[location].list_inventory()
        interactables = Hash.new
        contents.each do |object|
            interactables[object.name] = object
        end
        interactables
    end

    def get_room_text(location)
        room = @rooms[location]
        text = room.examine()
        text += "\nThe walls are of #{@material["color"].upcase} #{@material["adjective"].upcase} #{@material["name"].upcase}."
        contents = room.list_inventory()
        if contents.size > 0
            text += "\nIn the room you see: "
            text += concat_list(contents)
        end
        text
    end

    def build_dungeon(name)
        name = name + name.reverse
        tables = load_dungeon_build_table()
        chars = name.chars
        creator_type = tables["creators"][chars[0]]
        age = get_age(chars[1])
        climate = tables["climates"][chars[2]]
        current_occupier = tables["factions"][chars[3]]
        current_invader = tables["factions"][chars[4]]
        current_upstart = tables["factions"][chars[5]]
        function = tables["functions"][chars[6]]
        material = get_material(climate)
        room_types = get_room_types(creator_type, function)

        return creator_type, age, climate, current_occupier, current_invader, current_upstart, function, material, room_types
    end 

    def get_age(char)
        char.ord * 10
    end
end