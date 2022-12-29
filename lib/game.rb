require_relative "./io"
require_relative "./player"
require_relative "./dungeon"

class Game 
    attr_accessor :player
    attr_accessor :dungeon
    attr_accessor :text
    attr_accessor :command

    def initialize
        @io = DIO.new()
        name = get_name()
        @player = Player.new(name)
        @dungeon = Dungeon.new(name)
        @text = "You have entered a #{@dungeon.creator_type.upcase} #{@dungeon.function.upcase}.\nThe walls are of #{@dungeon.material["color"].upcase} #{@dungeon.material["adjective"].upcase} #{@dungeon.material["name"].upcase}."
        @command = ""
    end

    def render()
        text = ""
        command_text, show_room, @request = process_command(@player.location)
        text = text + "\n" + command_text
        if show_room
            room_text = @dungeon.get_room_text(@player.location)
            text = text + "\n" + room_text
        end
        commands = @dungeon.rooms[@player.location].get_commands()
        text = text + "\n" + "Commands: #{commands}"
        @text = text
    end

    def process_command(location)
        if @command == ""
            return "", true, ""
        else
            send(@command[0].downcase)
        end
    end

    def onward()
        if @player.location+1 == @dungeon.rooms.size
            @dungeon.add_room
        end
        @player.location +=1
        return "\nYou move ONWARD to the next room.", true, ""
    end

    def backward()
        @player.location -=1
        return "\nYou move BACKWARD to the previous room.", true, ""
    end

    def examine()
        if @command.size == 1
            return "", true, ""
        else
            return "", true, ""
        end
    end

    def get_name()
        name = ""
        while name.size < 4
            name = get_answer("What is your name, Player? (at least 4 characters)").downcase
        end
        name
    end
    
    def get_command()
        commands = @dungeon.rooms[@player.location].get_commands()
        if @request == ""
            @command = @io.input_command(commands)
        else
            @command = @io.input_command(commands, @request)
        end
        if @command[0] == "QUIT"
            false
        else
            true
        end
    end

    def get_answer(query = "")
        if query == ""
            @io.input_answer
        else
            @io.input_answer(query)
        end
    end

end