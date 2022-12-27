Class Dungeon
    attr_accessor rooms
    attr_accessor entities
    attr_accessor creator_type
    attr_accessor age 
    attr_accessor climate
    attr_accessor current_occupier
    attr_accessor current_invader
    attr_accessor current_upstart


    def initialize(name)
        @rooms = []
        @entities = []
    end
end