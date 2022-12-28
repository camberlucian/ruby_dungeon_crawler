require_relative "./io"
require_relative "./player"
require_relative "./dungeon"

class Game 
    attr_accessor :player
    attr_accessor :dungeon
    attr_accessor :text
    attr_accessor :command

    def initialize
        @io = IO.new(["onward", "backward", "inspect", "talk"])
        name = get_name()
        @player = Player.new(name)
        @dungeon = Dungeon.new(name)
        @text = ""
        @command = ""
    end

    def get_name()
        name = ""
        while name.size < 4
            name = get_answer("What is your name, Player? (at least 4 characters").downcase
        end
        name
    end
    
    def get_command()
        if @request == ""
            @command = @io.input_command
        else
            @command = @io.input_command(@request)
        end
        if @command[0].downcase == "quit"
            false
        else
            true
        end
    end

    def get_answer(query = "")
        if query = ""
            @command = @io.input_answer
        else
            @command = @io.input_answer(@request)
        end
    end

end