require 'byebug'
require_relative './tile.rb'

class Board

    def initialize(size = 3)
        @board = Array.new(size) {Array.new(size) {|ele| ele = Tile.new()}}
        @neighborMatrices = {"upLeft" => [-1,-1], "up" => [-1,0], "upRight" => [-1, 1], "left" => [0,-1], "right"=> [0,1], "downLeft" => [1,-1], "down" => [1,0], "downRight" => [1,1]}
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

    def getNeighborBombCount()
        for row in 0...@board.length
            for col in 0...@board[row].length
                posArray = [row, col]
                if self[posArray].bombStatus
                    
                end
            end
        end
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
        #read bookmarked page page 8 to understand algo
        
        for key in neighborMatrices.keys
            #set x and y equal to origin
            x, y = posArray
            x += neighborMatrices[key][0]
            y += neighborMatrices[key][1] #add x and y offset

            neighborPos = [x,y]
            if !self[neighborPos].revealed # check if tile has not been revealed
                if self[neighborPos].bombStatus
                    self[posArray].increment
                else
                    
                end
            end
        end
    end

    def checkStatus(posArray)
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