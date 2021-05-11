#!/usr/bin/env ruby
require 'optparse'
require './die.rb'
require './equation.rb'

options = {}
OptionParser.new do |parser|
    parser.banner = "Usage: cli.rb [options]"

    parser.on("-d", "--dice DICE", "The written explanation of the dice to roll") do |v|
        options[:dicestring] = v
    end

    parser.on("-v", "--verbose", "If supplied, the program will output all steps and rolls to generate the number") do |v|
        if v != nil
            options[:verbose] = true
        else
            options[:verbose] = false
        end
    end
end.parse!

if options[:dicestring]
    total_dice = options[:dicestring]
    eq = Equation.new(total_dice, options[:verbose])
    if options[:verbose]
        eq.calculate()
    else
        puts eq.calculate()
    end
else 
    puts 'Please supply an argument'
end