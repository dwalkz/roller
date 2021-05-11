
##
# Implement the Shunting-Yard algorithm for operator precedence which compiles the 
# algorithm in reverse polish notation using two stacks and then calculates it
# once all operators are in order
#
class ShuntingYard
    PRECEDENCE = {
        "(" => 0,
        ")" => 0,
        "+" => 1,
        "-" => 1,
        "*" => 2,
        "/" => 2,
        "^" => 3
    }

    ASSOCIATIVITY = {
        "+" => :left,
        "-" => :left,
        "*" => :left,
        "/" => :left,
        "^" => :right
    }

    def initialize(tokens)
        @tokens = tokens
    end

    ##
    # Parse the tokens using reverse polish notation and return the whole algorithm corrected in a way we can easily evaluate over
    #
    def parse()
        @stack = []
        @rpn = []

        @tokens.each do |symbol|
            shunt(symbol)
        end

        return @rpn.concat(@stack.reverse)
    end

    ##
    # Shunt a symbol onto the correct stack taking care to check precedence and bubble the stack as needed to keep reverse polish notation correct
    #
    def shunt(symbol) 
        if !is_operator(symbol) 
            @rpn << symbol
        elsif symbol == "(" 
            @stack << symbol
        elsif symbol == ")"
            until @stack.last == "("
                @rpn << @stack.pop
            end

            @stack.pop
        elsif @stack.empty? or @stack.last == "(" 
            @stack << symbol
        elsif is_higher_or_right(symbol) 
            @stack << symbol
        else 
            until @stack.empty? or (is_higher_or_right(symbol))
                @rpn << @stack.pop
            end

            @stack << symbol
        end
    end

    ##
    # Test whether the current symbol is of higher precedence or is right associative
    #
    # @return [Boolean] true if the symbol has higher precedence than the top of the stack or is right associative
    def is_higher_or_right(symbol)
        higher = PRECEDENCE[symbol] > PRECEDENCE[@stack.last]
        equal = PRECEDENCE[symbol] == PRECEDENCE[@stack.last]
        right = ASSOCIATIVITY[symbol] == :right

        return higher || (equal && right)
    end

    ##
    # Test whether the symbol is an operator character
    #
    # @return [Boolean] true if the symbol is an operator
    def is_operator(symbol)
        return !!PRECEDENCE[symbol]
    end
end