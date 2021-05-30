require_relative './board.rb'

class Tile

    attr_accessor :neighborBombCount
    
    def initialize(bombStatus)
        @bombStatus = bombStatus
        @revealed = false
        @flagged = false
        @neighborBombCount = 0
    end

    def flag(posArray)
        @flagged = true
        return nil
    end

    def reveal(posArray)
        @revealed = true
        return nil
    end
end