##
# Represents a single die of specified number of faces that can roll a number between 1 and the number of faces inclusively
class Die

    ##
    # Creates a new die with specified number of faces
    #
    # @param faces [Integer] the highest face value this die can show
    #
    def initialize(faces)
        @faces = faces
        @current_roll = 0
    end

    ## 
    # Roll a number on this die and set the current value. 
    # Values can be between 1 and {#Die.faces} inclusive
    def roll()
        @current_roll = 1 + Random.rand(@faces)
    end

    ##
    # Return the current face value of the die
    #
    # @return [Integer] the current face value of the last roll
    def value()
        return @current_roll
    end

    ##
    # Return a string to describe what kind of die this is.
    #
    # @return [String] String describing the die faces
    def describe()
        return "d" +  @faces.to_s()
    end

end
