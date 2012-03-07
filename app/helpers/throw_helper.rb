module ThrowHelper
  def rps_play(play)
    @defeat = { rock: :scissors, paper: :rock, scissors: :paper }
    @throws = @defeat.keys
    @player_throw = play.to_sym
    if !@throws.include?(@player_throw)
      halt 403, "You must throw one of the following: #{@throws}"
    end
    @computer_throw = @throws.sample
    if @player_throw == @computer_throw
      @msg = "You tied with the computer.  Try again!"
    elsif @computer_throw == @defeat[@player_throw]
      @msg = "Nicely done, #{@player_throw} beats #{@computer_throw}!"
    else
      @msg = "Ouch; #{@computer_throw} beats #{@player_throw}.  Better luck next time!"
    end
  end
end
