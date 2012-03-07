class ThrowController < ApplicationController

  def get_wins
    s = session[:wins]
    if !s 
      s = {computer: 0, player: 0, ties: 0}
      session[:wins] = s
    end
    return s
  end

  def rps_play(play)
    @defeat = { rock: :scissors, paper: :rock, scissors: :paper }
    @throws = @defeat.keys
    wins = get_wins
    @player_throw = play.to_sym
    if !@throws.include?(@player_throw)
      halt 403, "You must throw one of the following: #{@throws}"
    end
    @computer_throw = @throws.sample
    if @player_throw == @computer_throw
      wins[:ties] += 1
      @msg = "You tied with the computer.  Try again!"
    elsif @computer_throw == @defeat[@player_throw]
      wins[:player] += 1
      @msg = "Nicely done, #{@player_throw} beats #{@computer_throw}!"
    else
      wins[:computer] += 1
      @msg = "Ouch; #{@computer_throw} beats #{@player_throw}.  Better luck next time!"
    end
    session[:wins] = wins
  end

  def stats
    @title = "Statistics"
    wins = get_wins
    @msg = "Stats: Computer: #{wins[:computer]}, Human: #{wins[:player]}, Ties: #{wins[:ties]}"
  end

  def rock
    @title = "Rock"
    rps_play("rock")
  end

  def paper
    @title = "Paper"
    rps_play("paper")
  end

  def scissors
    @title = "Scissors"
    rps_play("scissors")
  end

  def instructions
    @title = "Instructions"
  end

end
