require_relative "cursor"
require "colorize"

class Display
    attr_accessor :notifications
    attr_reader :cursor
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
        @notifications = {check: false, checkmate: false, error: false}
    end

    def render
        system("clear")
        @board.rows.each_with_index do |r, i|
            puts r.each_with_index.map{|e, j| e.symbol.colorize(correct_color(i,j))}.join('')
        end
        puts "#{@notifications[:check]} is in check!" if @notifications[:check]
        puts "#{@notifications[:checkmate]} has been checkmated!" if @notifications[:checkmate]
    end

    def correct_color(i,j)
        if @cursor.cursor_pos == [j,i] && @cursor.selected
            bg = :light_green
        elsif @cursor.cursor_pos == [j,i]
            bg = :light_red
        elsif (i + j).odd?
            bg = :light_blue
        else 
            bg = :light_magenta
        end
        {background: bg} 
    end
    def get_input
        @cursor.get_input
    end

    def clear_errors
        @notifications.delete(:error)
    end

    def clear_check
        @notifications.delete(:check)
    end


end