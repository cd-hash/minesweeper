require_relative './tile.rb'

class Board

    def initialize(size = 3)
        @board = Array.new(size) {Array.new(size) {|ele| ele = Tile.new()}}
        @bombNum = 2
    end

    def numBombs()
        return @board.flatten.count {|ele| ele.bombStatus}
    end

    def [](posArray)
        row, col = posArray
        return @board[row][col]
    end

    def []=(posArray)
        row, col = posArray
        @board[row][col].reveal()
        return true
    end


    def placeBombs()
        while self.numBombs < @bombNum
            randRow = rand(0...3)
            randCol = rand(0...3)
            randArray = [randRow, randCol]
            self[randArray].bombStatus = true
        end
    end

    def reveal(posArray)
        self[posArray].reveal
        return self[posArray].bombStatus
    end

    def render
        puts "-" * 30
        for row in @board
            outputString = "|"
            for ele in row
                if !ele.revealed
                    outputString += " _ |"
                else
                    if ele.bombStatus
                        outputString += " X |"
                    else
                        outputString += " #{ele.neighborBombCount} |"
                    end
                end
            end
            puts outputString
        end
        puts "-" * 30
    end
end