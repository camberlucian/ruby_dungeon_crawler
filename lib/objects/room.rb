require_relative "../tables/dungeon_tables"
require_relative "./container"
require_relative "./object"

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
        @object_type = "room"
    end

    def populate(occupier, invader, upstart, function, events = [])
        types = ["faction", "function", "furniture", "clutter", "mundane", "clutter", "mundane", "container", "event", "hidden_item"]
        factions = [occupier, invader, upstart]
        objects = 0
        while objects < 6
            if rand(1..3) >1
                type = types.sample
                object = DObject.new
                if type == "event"
                    object = get_event_object(factions)
                elsif type == "faction"
                    object = get_faction_object(factions.sample)
                elsif type == "function"
                    object = get_object(function)
                elsif type == "hidden_item"
                    type = (types - ["hidden_item", "container", "faction", "event"]).sample
                    object = get_hidden_item(type)
                else
                    object = get_object(type)
                end
                @inventory << object 
            end
            objects += 1   
        end
        events
    end

    def get_commands()
        @commands
    end
end