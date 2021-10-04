require_relative './board.rb'

class Game
    def initialize(size = 3)
        @gameBoard = Board.new(size)
        @gameOver = true
    end

    def getCommand()
        puts "You can guess or flag a location on the board with notation guess 1 1"
        cmd, *args = gets.chomp.split(" ")

        case cmd
        when "flag"
            @gameBoard.flagTile(args)
        when "guess"
            return @gameBoard.reveal(args)
        when "cheat"
            @gameBoard.cheat()
        else
            puts "Sorry that command is not recognized"
        end
    end

    def play()
        @gameBoard.placeBombs()
        @gameBoard.getNeighborBombCount()
        @gameBoard.cheat()
        while !@gameBoard.won?
            if !getCommand()
                @gameBoard.render()
                @gameOver = false
                break
            end
            @gameBoard.render()
        end
        if @gameOver
            puts "You Won!!!"
        else
            puts "You Lost!!"
        end
    end
end



if __FILE__ == $PROGRAM_NAME
    g = Game.new
    g.play
end