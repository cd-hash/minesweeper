require_relative './board.rb'

class Tile

    attr_accessor :neighborBombCount, :bombStatus

    def initialize()
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
end