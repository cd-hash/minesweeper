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
        self[posArray].reveal
        return self[posArray].bombStatus
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

    def checkNeighbors(posArray)
        row, col = posArray
        #assume the postition is not a bomb
        #read bookmarked page page 8 to understand algo
        for key in @neighborMatrices.keys
            # debugger
            newRow = row + @neighborMatrices[key][0]
            newCol = col + @neighborMatrices[key][1]
            newPosition = [newRow, newCol]

            if self[newPosition] && !self[newPosition].neighborBombCount
                reveal(newPosition)
                checkNeighbors(newPosition)
            else
                return
            end
        end
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

end