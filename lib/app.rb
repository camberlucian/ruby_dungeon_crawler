require_relative './game'

def run
    on = true
    game = Game.new
    puts(game.text)
    while on
        game.render
        puts game.text
        on = game.get_command
    end
end

run()
