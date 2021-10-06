require 'yaml'
require 'byebug'
require_relative './board.rb'

class Game
    def initialize(size = 3)
        @size = size
        @gameOver = true
        @gameSaved = true
    end

    def getCommand(gameBoard)
        puts "You can guess or flag a location on the board with notation guess 1 1"
        cmd, *args = gets.chomp.split(" ")

        case cmd
        when "flag"
            gameBoard.flagTile(args)
        when "guess"
            return gameBoard.reveal(args)
        when "cheat"
            gameBoard.cheat()
        when "save"
            saveGame(gameBoard)
            @gameSaved = false
        else
            puts "Sorry that command is not recognized"
        end
    end

    def saveGame(gameBoard)
        File.open("gameSave.yml", "w") {|file| file.write(gameBoard.to_yaml)}
    end

    def startGame(boardSize)
        if ARGV.length() > 0
            gameBoard = YAML.load(File.read(ARGV.shift()))
        else
            gameBoard = Board.new(boardSize)
        end
        gameBoard.placeBombs()
        gameBoard.getNeighborBombCount()
        gameBoard.cheat()
        return gameBoard
    end

    def play()
        gameBoard = startGame(@size)
        #debugger
        while !gameBoard.won? && @gameSaved
            if !getCommand(gameBoard)
                gameBoard.render()
                @gameOver = false
                break
            end
            gameBoard.render()
        end
        if @gameOver
            puts "You Won!!!"
        else
            puts "You Lost!!"
        end
        if !@gameSaved
            puts "you saved the game pass the save file as an argument to continue next time"
        end
    end
end



if __FILE__ == $PROGRAM_NAME
    g = Game.new
    g.play()
end