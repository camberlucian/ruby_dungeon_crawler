require_relative "./object"

class Container < DObject
    def initialize(name = "container", desc = "It seems like a container of some sort", type = "container")
        super
        @inventory = []
        @commands << "SEARCH"
    end

    def inventory()
        @inventory
    end

    def insert(item)
        @inventory << item
    end

    def remove(item)
        index = @inventory.index(item)
        @inventory.delete_at(index)
        item
    end
end