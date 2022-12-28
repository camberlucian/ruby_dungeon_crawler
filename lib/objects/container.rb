class Container < Object
    def initialize()
        @inventory = []
        @description = "It seems like a container of some sort"
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