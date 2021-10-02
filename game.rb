require_relative './board.rb'

class Game
    def initialize(size = 3)
        @gameBoard = Board.new(size)
    end

    def getCommand()
        puts "You can guess or flag a location on the board with notation guess 1 1"
        cmd, *args = gets.chomp.split(" ")

        case cmd
        when "flag"
            @gameBoard.flagTile(*args)
        when "guess"
            @gameBoard.reveal(args)
        when "cheat"
            @gameBoard.cheat()
        else
            puts "Sorry that command is not recognized"
        end
    end

    def play()

    end
end



if __FILE__ == $PROGRAM_NAME
    g = Game.new
    g.play
end