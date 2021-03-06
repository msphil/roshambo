require 'spec_helper'

describe ThrowController do
  render_views

  describe "GET 'rock'" do
    it "should be successful" do
      get 'rock'
      response.should be_success
    end

    it "should have the right title" do
      get 'rock'
      response.should have_selector("title", :content => "Roshambo | Rock")
    end

  end

  describe "GET 'paper'" do
    it "should be successful" do
      get 'paper'
      response.should be_success
    end

    it "should have the right title" do
      get 'paper'
      response.should have_selector("title", :content => "Roshambo | Paper")
    end

  end

  describe "GET 'scissors'" do
    it "should be successful" do
      get 'scissors'
      response.should be_success
    end

    it "should have the right title" do
      get 'scissors'
      response.should have_selector("title", :content => "Roshambo | Scissors")
    end

  end

  describe "GET 'stats'" do
    it "should be successful" do
      get 'stats'
      response.should be_success
    end

    it "should have the right title" do
      get 'stats'
      response.should have_selector("title", :content => "Roshambo | Statistics")
    end

  end

  describe "Play a predictable losing game (check header)" do
    it "should be successful" do
      # Make the PRNG predictable
      # First play is "paper"
      srand(0)
      get 'rock'
      # Based on a test run, this results in a predictable game
      response.should have_selector("h1", :content => "Rock!")
    end
  end

  describe "Play a predictable losing game (check body)" do
    it "should be successful" do
      # Make the PRNG predictable
      # First play is "paper"
      srand(0)
      get 'rock'
      # Based on a test run, this results in a predictable game
      response.should have_selector("p", :content => "Ouch")
    end
  end

  describe "Play a predictable losing game (check session)" do
    it "should be successful" do
      # Make the PRNG predictable
      # First play is "paper"
      srand(0)
      get 'rock'
      # Based on a test run, this results in a predictable game
      expected_wins = { computer: 1, player: 0, ties: 0 }
      wins = session[:wins]
      wins.should == expected_wins
    end
  end

  describe "Play a predictable winning game (check session)" do
    it "should be successful" do
      # Make the PRNG predictable
      # First play is "paper"
      srand(0)
      get 'scissors'
      # Based on a test run, this results in a predictable game
      expected_wins = { computer: 0, player: 1, ties: 0 }
      wins = session[:wins]
      wins.should == expected_wins
    end
  end

  describe "Play a predictable winning game (check body)" do
    it "should be successful" do
      # Make the PRNG predictable
      # First play is "paper"
      srand(0)
      get 'scissors'
      # Based on a test run, this results in a predictable game
      response.should have_selector("p", :content => "Nicely done")
    end
  end

  describe "Play a predictable tie game (check session)" do
    it "should be successful" do
      # Make the PRNG predictable
      # First play is "paper"
      srand(0)
      get 'paper'
      # Based on a test run, this results in a predictable game
      expected_wins = { computer: 0, player: 0, ties: 1 }
      wins = session[:wins]
      wins.should == expected_wins
    end
  end

  describe "Play a predictable tie game (check body)" do
    it "should be successful" do
      # Make the PRNG predictable
      # First play is "paper"
      srand(0)
      get 'paper'
      # Based on a test run, this results in a predictable game
      response.should have_selector("p", :content => "You tied")
    end
  end

  describe "Play a few games" do
    it "should be successful" do
      # Make the PRNG predictable
      srand(0)
      get 'rock'
      get 'paper'
      get 'scissors'
      get 'rock'
      get 'paper'
      get 'scissors'
      # Based on a test run, this results in a predictable game
      expected_wins = { computer: 3, player: 2, ties: 1 }
      wins = session[:wins]
      wins.should == expected_wins
    end
  end

end
