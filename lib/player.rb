class Player
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

    def initialize(name)
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
    end
end