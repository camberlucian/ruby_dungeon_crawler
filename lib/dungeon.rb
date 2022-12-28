
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


    def initialize(name)
        @rooms = []
        @entities = []
        @creator_type, @age, @climate, @current_occupier, @current_invader, @current_upstart, @material = build_dungeon(name)
        @rooms[0] = Room.new(@creator_type, @function, true)

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

        return creator_type, age, climate, current_occupier, current_invader, current_upstart, material
    end 

    def get_age(char)
        char.ord * 10
    end
end