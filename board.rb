require 'byebug'
require_relative './tile.rb'

class Board

    def initialize(size = 3)
        @size = size
        @board = Array.new(size) {Array.new(size) {|ele| ele = Tile.new()}}
        @neighborMatrices = {"upLeft" => [-1,-1], "up" => [-1,0], "upRight" => [-1, 1], "left" => [0,-1], "right"=> [0,1], "downLeft" => [1,-1], "down" => [1,0], "downRight" => [1,1]}
        @bombNum = 1
    end

    def numBombs()
        return @board.flatten.count {|ele| ele.bombStatus}
    end

    def [](posArray)
        row, col = posArray
        if row < 0 || row > @size - 1 || col < 0 || col > @size - 1
            return false
        else
            return @board[row][col]
        end
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

    def getNeighborBombCount()
        for row in 0...@board.length
            for col in 0...@board[row].length
                posArray = [row, col]
                
                if self[posArray].bombStatus
                    # debugger
                    for key in @neighborMatrices.keys
                        newRow = posArray[0] + @neighborMatrices[key][0]
                        newCol = posArray[1] + @neighborMatrices[key][1]
                        newPosition = [newRow, newCol]

                        if self[newPosition] && !self[newPosition].bombStatus
                            self[newPosition].increment
                        end
                    end
                end
            end
        end
        return nil
    end

    def reveal(posArray)
        if self[posArray].reveal
            return false # we hit a bomb game over
        elsif self[posArray].neighborBombCount # we hit a tile adjacent to a bomb
            self[posArray].reveal
            return true
        end
        self[posArray].reveal
        # debugger
        for key in @neighborMatrices.keys
            row, col = posArray
            newRow = row + @neighborMatrices[key][0]
            newCol = col + @neighborMatrices[key][1]
            newPosition = [newRow, newCol]
            # check if position is valid and has not already been revealed
            if self[newPosition] && !self[newPosition].revealed  
                reveal(newPosition)
            end
        end
        return true
    end

    def render
        rowCounter = 0
        puts "-" * 30
        for row in @board
            outputString = "#{rowCounter} |"
            for ele in row
                if !ele.revealed
                    outputString += "|_ "
                else
                    if ele.bombStatus
                        outputString += " X |"
                    else
                        outputString += " #{ele.neighborBombCount} |"
                    end
                end
            end
            puts outputString
            rowCounter += 1
        end
        puts "-" * 30
    end



    def revealAll()
        rowCounter = 0
        puts "-" * 30
        for row in @board
            outputString = "#{rowCounter} |"
            for ele in row
                outputString += "#{ele.to_s}"
            end
            puts outputString
            rowCounter += 1
        end
        puts "-" * 30
    end

    def flagTile(posArray)
        self[posArray].flag
        return true
    end
end