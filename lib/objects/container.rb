require_relative "./object"
require_relative "../tables/item_tables"

class Container < DObject
    def initialize(name = "container", desc = "It seems like a container of some sort", type = "container", faction = "none")
        super
        @inventory = []
        @commands << "SEARCH"
        @description += " It may be searched."
        @object_type = type
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

    def fill(amt=6)
        @inventory = @inventory + get_container_inventory(amt)
    end
end