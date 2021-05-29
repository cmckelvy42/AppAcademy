require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    children = node.children
    children.each{|c| return c.prev_move_pos if c.winning_node?(mark)}
    children.each{|c| return c.prev_move_pos if !c.losing_node?(mark)}
    raise "How did you manage?"
    nod
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new
  game = TicTacToe.new(hp, cp)
  game.board[[0, 0]] = :x
  game.board[[2, 0]] = :x
  game.board[[1, 0]] = :o
  game.board[[2, 1]] = :o
  p cp.move(game, :x)
  
end
