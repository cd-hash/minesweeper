require_relative './board.rb'

class Tile

    attr_accessor :bombStatus
    attr_reader :revealed, :neighborBombCount

    def initialize(gameBoard)
        @bombStatus = false
        @revealed = false
        @flagged = false
        @neighborBombCount = 0
    end

    def flag
        @flagged = true
        return nil
    end

    def reveal
        @revealed = true
        return nil
    end
    
    def to_s
        return @neighborBombCount.to_s
    end

    def increment
        @neighborBombCount += 1
    end
end