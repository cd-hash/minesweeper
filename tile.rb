

class Tile

    attr_accessor :bombStatus
    attr_reader :revealed, :neighborBombCount

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
    
    def to_s
        if @bombStatus
            return "X"
        else
            return @neighborBombCount.to_s
        end
    end

    def increment
        @neighborBombCount += 1
    end
end