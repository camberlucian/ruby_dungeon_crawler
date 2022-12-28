class IO
    @commands = ["quit", "help"]

    def initialize(commands)
        @commands.concat(commands)
    end
    
    def input_command(query = "Please enter a command.")
        puts query
        valid = false
        user_input = ""
        while !valid do
            user_unput = gets.chomp.split(" ")
            if @commands.include?(user_input[0])
                valid = true
            else
                puts "Please start your command with a word from the list below. Separate words with spaces:"
                puts @commands.inspect
            end
        end
        user_input
    end

    def input_answer(query = "Please enter an answer. (Alphanumeric only)")
        user_input = ""
        while user_input = "" || !validate(user_input)
            puts query
            user_unput = gets.chomp
        end
        user_input
    end

    def validate str
        chars = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
        str.chars.detect {|ch| !chars.include?(ch)}.nil?
    end
end