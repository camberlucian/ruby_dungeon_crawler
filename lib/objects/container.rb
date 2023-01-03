require_relative "./object"
require_relative "../tables/item_tables"

class Container < DObject
    def initialize(name = "container", desc = "It seems like a container of some sort", type = "container", faction = "none")
        super
        @inventory = Hash.new()
        @commands << "SEARCH"
        @description += " It may be searched."
        @object_type = type
    end

    def inventory()
        @inventory
    end

    def list_inventory()
        list = []
        @inventory.each do |key, value|
            list << value
        end
        list
    end

    def insert(item)
        @inventory[item.name] = item
    end

    def remove(item_name)
        @inventory.delete(item_name)
    end

    def fill(amt=6)
        @inventory = get_container_inventory(amt, @name)
    end
end