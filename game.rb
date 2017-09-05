require 'player.rb'

class Game
  attr_accessor :player1, :player2
  def initialize(player1, player2)
    @player1 = Player.new("jeff")
    @player2 = Player.new("omar")
    @fragment = ""
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @current_player = @player1
  end

  def play_round(current_player)
    until won?
      take_turn(@current_player)
      next_player!
    end
  end

  def valid_play?(letter)
    return false unless ('a'..'z').to_a.include?(letter)
    num = @dictionary.count do |word|
      new_frag = (@fragment + letter) || letter
      word[0..(new_frag.length - 1)] == new_frag
    end
    return false if num.zero?
    true
  end

  def take_turn(player)
    player.guess
    @fragment += letter if valid_play?(letter)
  end




  def next_player!
    @current_player == @player1 ? current_player = @player2 : @current_player= player1
  end
  def won?
    @dictionary.include?(@fragment)
  end


end
game = Game.new#(player1, player2)
p game.valid_play?("z")
