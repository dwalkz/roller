require './die.rb'
require './shunt.rb'

##
# Represents an equation to solve by rolling dice and performing arithmatic
class Equation
    DIE_FORMAT = /^\d+d\d+$/
    VALUE_FORMAT = /^\d+$/
    OPERATORS = /(\+|\-|\*|\/)/

    EVAL = {
        "+" => lambda { |a, b| a + b } ,
        "-" => lambda { |a, b| a - b },
        "*" => lambda { |a, b| a * b },
        "/" => lambda { |a, b| a / b },
        "^" => lambda { |a, b| a ** b }
    }

    ##
    # Create a new instance of an equation with a specific string
    #
    # @param [String] string    The actual input equation that we're trying to calculate
    # @param [Boolean] verbose  If true, we'll output extra information about the equation
    def initialize(string, verbose)
        @equation = string
        @verbose = verbose
        @equation_tokens = []
        @stack = []
        @rpn = []
    end

    ## 
    # Calculate and return the output of the dice rolls described by the equation
    # 
    # @return [Integer] The outcome of the process
    def calculate()
        @equation_tokens = @equation.split(/(\+|\-|\*|\/|\(|\))/).reject { |a| a.empty? }
        if @verbose
            puts "1: #{@equation_tokens.join}"
        end

        @equation_tokens = calculate_tokens(@equation_tokens)
        if @verbose
            puts "2: #{@equation_tokens.join}"
        end

        result = []
        yard = ShuntingYard.new(@equation_tokens)
        rpn = yard.parse()
        rpn.each do |symbol|
            result << (
                if EVAL[symbol] 
                    right = result.pop
                    left = result.pop
                    EVAL[symbol].call(left, right)
                else
                    symbol
                end)
        end

        value = result.pop
        if @verbose
            puts "3: #{value}"
        end

        return value
    end

    ##
    # Internal handler which will process the equation initially and convert dice values into actual values 
    #
    # @param [Array] tokens     An array of strings representing individual values, operators, or dice
    private def calculate_tokens(tokens)
        tokens.each_with_index do |token, i|
            if DIE_FORMAT =~ token
                die_params = token.split(/d/)
                curr_die = Die.new(die_params[1].to_i)
                total_single_dice_roll = 0
                for n in 1..die_params[0].to_i()
                    curr_die.roll()
                    if @verbose
                        puts "\t" + curr_die.describe() + " rolled " + curr_die.value().to_s()
                    end
                    total_single_dice_roll += curr_die.value()
                end
                tokens[i] = total_single_dice_roll
            elsif VALUE_FORMAT =~ token
                tokens[i] = token.to_i()
            end
        end

        return tokens
    end
end
