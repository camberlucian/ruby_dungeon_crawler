class Player
    attr_accessor :location
    attr_accessor :sanity
    attr_accessor :martial
    attr_accessor :intel 
    attr_accessor :percep
    attr_accessor :dex
    attr_accessor :str 
    attr_accessor :cha
    attr_accessor :con 
    attr_accessor :allegiance
    attr_accessor :empathy
    attr_accessor :name 
    attr_accessor :inventory
    attr_accessor :commands
    

    def initialize(name)
        @location = 0
        @name = name
        @allegiance = ["overworld"]
        @sanity = 10
        @martial = 10
        @intel = 10
        @percep = 10
        @dex = 10
        @str = 10
        @cha = 10
        @con = 10
        @empathy = 5

        @inventory = Hash.new
        @commands = ["INV"]
    end

    def take(item)
        @inventory[item.name] = item
    end

    def list_inventory()
        list = []
        @inventory.each do |key, value|
            list << value
        end
        list
    end

end