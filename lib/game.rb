require_relative "./io"
require_relative "./helpers"
require_relative "./player"
require_relative "./dungeon"

class Game 
    attr_accessor :player
    attr_accessor :dungeon
    attr_accessor :text
    attr_accessor :command
    attr_accessor :commands

    def initialize
        @io = DIO.new()
        name = get_name()
        @player = Player.new(name)
        @dungeon = Dungeon.new(name)
        @text = "\nYou have entered a #{@dungeon.creator_type.upcase} #{@dungeon.function.upcase}."
        @command = ""
        @interactables = Hash.new
        @takables = Hash.new
        @commands = []
    end

    def render()
        text = ""
        command_text, show_room, @request = process_command(@player.location)
        text = text + "\n" + command_text
        @interactables = @dungeon.get_interactables(@player.location)
        if show_room
            room_text = @dungeon.get_room_text(@player.location)
            text = text + "\n" + room_text
        end
        @commands = @dungeon.rooms[@player.location].get_commands() + is_take?() + @player.commands
        text = text + "\n" + "Commands: #{commands}"
        @text = text
    end

    def is_take?()
        if @takables.size > 0
            ["TAKE"]
        else
            []
        end
    end

    def process_command(location)
        if @command == ""
            return "", true, ""
        else
            send(@command[0].downcase)
        end
    end

    def onward()
        @takables = Hash.new
        @interactables = Hash.new
        if @player.location+1 == @dungeon.rooms.size
            @dungeon.add_room
        end
        @player.location +=1
        return "\nYou move ONWARD to the next room.", true, ""
    end

    def inv()
        if @player.inventory.size < 1
            return "Your inventory is empty", true, ""
        else
            text = "Your inventory contains: "
            inv = @player.list_inventory()
            text += concat_list(inv)
            return text, true, ""
        end
    end

    def backward()
        @takables = Hash.new
        @interactables = Hash.new
        @player.location -=1
        return "\nYou move BACKWARD to the previous room.", true, ""
    end

    def examine()
        if @command.size == 1
            return "", true, ""
        else
            text = examine_object(@command[1..])
            return text, true, ""
        end
    end

    def examine_object(command)
        name = command.join(" ").downcase
        if @interactables.key?(name)
            @interactables[name].examine()
        else
            "You can see no #{name.upcase} in this room."
        end
    end

    def search()
        if @command.size < 2
            search_room(@player.location)
        else
            target = @command[1..].join(" ").downcase
            text = ""
            if @interactables.key?(target)
                text = search_object(target)
            else
                text = "You can see no #{target.upcase} in this room."
            end
            return text, false, ""
        end
    end

    def search_room(location)
        room = @dungeon.rooms[location]
        text = @dungeon.get_room_text(location)
        containers = room.list_inventory().select {|object| object.object_type == "container"}
        if containers.size > 0
            text += "\nYou may SEARCH the following items: #{concat_list(containers)}"
        end
        return text, false, ""
    end

    def search_object(target)
        object = @interactables[target]
        if object.object_type == "container"
            text = "In this #{target.upcase} you "
            if object.list_inventory().size < 1
                text += "do not find anything..."
            else
                object.list_inventory().each do |item|
                    @takables[item.name] = item
                end
                text += "find: #{concat_list(object.list_inventory())}"
            end
        else
            "This #{target.upcase} can not be searched."
        end
    end

    def take()
        if command.size < 2
            return "Take what?", false, ""
        else
            target = @command[1..].join(" ").downcase
            text = ""
            if @takables.key?(target)
                text = take_item(target)
            else
                text = "You can see no #{target.upcase} in this room."
            end
            return text, false, ""
        end
    end

    def take_item(target)
        item = @takables[target]
        container = @interactables[item.location]
        container.remove(item.name)
        @player.take(item)
        "You take the #{item.name.upcase} from the #{item.location.upcase}."
    end

    def get_name()
        name = ""
        while name.size < 4
            name = get_answer("What is your name, Player? (at least 4 characters)").downcase
        end
        name
    end
    
    def get_command()
        if @request == ""
            @command = @io.input_command(@commands)
        else
            @command = @io.input_command(@commands, @request)
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