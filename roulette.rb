require "pry"
require "colorize"

# This class allows a user to play a game of roulette and win in-game money
# Inputs: 
#      - Player class: Includes @player (name) and @wallet (funds available to use)
# Outputs:
#      - Player class: With updated funds based on their performance in the games of roulette
class Roulette
    attr_accessor :wallet, :player, :roulette_wheel, :bet_array, :winning_number
    
    def initialize(player)
      @player = player
      @wallet = player.wallet
      @bet_array = []

      # Assembles the necessary data to play a single game of roulette
      build_game_instance

      # Choose where you put your chips & your wallet amount
      # Must not allow for more betting than you have in your wallet
      place_bets

      # Spin the wheel & randomly choose the winning number
      spin_the_wheel
  
      # Calculate the winnings for the user, and add to wallet
      calculate_winnings

      # Play again or cash out & exit
      repeat_game
    end


    # Builds the necessary arrays and variables to start a game of roulette
    def build_game_instance
      @roulette_wheel = (0..36).to_a # Establishes array of possible numbers
      @roulette_wheel.push("00") # Adds 00
      @roulette_wheel.each_with_index do |number,index|
          @roulette_wheel[index] = number.to_s # converts each number to a string
      end

      @bet_options = ["Any Single Number","00","red","black","odd","even","1-18",
        "19-36","1-12","13-24","25-36"]

      # Combines all options into one array, and flattens this array  
      @bet_options.push((0..36).to_a)
      @bet_options.flatten!
     
      # Makes sure everything is a string
      @bet_options.each_with_index do |number,index|
        @bet_options[index] = number.to_s
      end
      
      # Builds arrays for red and black colors on the roulette table
      @red = [1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36]
      @black = [2,4,6,8,10,11,13,15,17,20,22,24,26,28,29,32,33,35]
    end


    # This method allows the user to enter in their bet
    def place_bets
      @roulette_wheel
      print `clear`
      puts "Royal".colorize(:blue) + " Roulette".colorize(:yellow)
      puts "-----------------------"
      puts "Your wallet currently has $#{@wallet}\n".colorize(:blue)
      puts "What do you want to bet on?"
      puts "Your options are: "

      # Loop through and print bet options
      i = 0
      while i < 10
        print @bet_options[i]      
        print ", "
        i = i + 1
      end
      puts @bet_options[10] # prints final value w/o comma
      
      # Asks user for how much they would like to place on that particular bet
      print "> "
      bet_option = gets.strip.downcase
      puts "And how much do you want to bet on that?"
      print "> $"
      bet_amount = gets.to_i
      
      # Tests whether user has enough funds to make the bet
      if bet_amount > @wallet
        puts "Not enough funds in your wallet!"
        puts "Try a different bet amount, or exit."
      else # Saves the bet, and withdraws funds from wallet
        @bet_array.push(Bet.new(bet_option,bet_amount))
        @wallet -= bet_amount
      end

      continue_bets # Identifies whether the user wants to keep betting more
    end


    # Allows user to loop through and add another bet if they still have money
    def continue_bets
      puts "Do you want to bet anything else? (y/n)"
      choice = gets.strip.downcase
      case choice
      when "y"
        place_bets
      when "n"
        puts "All Bets In."
        sleep(1)
        return
      else
        puts "Invalid Choice"
        continue_bets # repeats loop
      end
    end
  

    # Allows user to spin the wheel and returns the winning number
    def spin_the_wheel
      puts "\n-----------------------"
      puts "To spin the wheel, press 'Enter'"
      print "> "
      choice = gets.to_s
      if choice == "\n"
        @winning_number = roulette_wheel.sample
        spin_loop(5)
        puts "The ball landed on: #{@winning_number}!\n"
        sleep(1)
      else
        puts "Invalid, try again"
        spin_the_wheel
      end
    end


    # Simple output to show that the wheel is "turning"
    def spin_loop(number_of_iterations)
      for i in 1..number_of_iterations do
        puts "."
        sleep(0.5)
      end
    end


    # Calculates the winnings of the spin based on the user's series of bets
    def calculate_winnings
      # Calculate numbers
      winnings_amount = 0
      bet_lost_flag = true

      @bet_array.each_with_index do |bet,index| 
        # Checks whether the user bet on a single number, and that number won
        if bet.bet_option == @winning_number
          winnings_amount += bet.bet_amount * 34
          puts "Winning number is #{winning_number}, you won!".colorize(String.colors.sample)
          bet_lost_flag = false
        end

        # Checks whether any of the other bets won
        case bet.bet_option
        when "even"
          if @winning_number.to_i % 2 == 0
            puts "Winning number is even, ou won!".colorize(String.colors.sample)
            winnings_amount += bet.bet_amount * 2
            bet_lost_flag = false
          end
        when "odd"
          if @winning_number.to_i % 2 == 1
            puts "Winning number is odd, ou won!".colorize(String.colors.sample)
            winnings_amount += bet.bet_amount * 2
            bet_lost_flag = false
          end
        when "red"
          if @red.include?(@winning_number.to_i)
            puts "Winning number is red, you won!".colorize(String.colors.sample)
            winnings_amount += bet.bet_amount * 2
            bet_lost_flag = false
          end
        when "black"
          if @black.include?(@winning_number.to_i)
            puts "Winning number is black, you won!".colorize(String.colors.sample)
            winnings_amount += bet.bet_amount * 2
            bet_lost_flag = false
          end
        when "1-18"
          if @winning_number.to_i <= 18
            puts "Winning number is between 1 and 18, you won!".colorize(String.colors.sample)
            winnings_amount += bet.bet_amount * 2
            bet_lost_flag = false
          end
        when "19-36"
          if @winning_number.to_i > 18
            puts "Winning number is between 19 and 36, you won!".colorize(String.colors.sample)
            winnings_amount += bet.bet_amount * 2
            bet_lost_flag = false
          end
        when "1-12"
          if @winning_number.to_i <= 12
            puts "Winning number is between 1 and 12, you won!".colorize(String.colors.sample)
            winnings_amount += bet.bet_amount * 3
            bet_lost_flag = false
          end
        when "13-24"
          if @winning_number.to_i > 12 && @winning_number <= 24
            puts "Winning number is between 13 and 24, you won!".colorize(String.colors.sample)
            winnings_amount += bet.bet_amount * 3
            bet_lost_flag = false
          end
        when "25-36"
          if @winning_number.to_i > 24 && @winning_number <= 36
            puts "Winning number is between 25 and 36, you won!".colorize(String.colors.sample)
            winnings_amount += bet.bet_amount * 3
            bet_lost_flag = false
          end
        end
      end

      # Finally, check whether the user did not win at all
      # If the user did not win, then the bet_lost_flag will have remained true
      if bet_lost_flag
        puts "Sorry, you did not win anything!"
      else
        puts "For this game, you won $#{winnings_amount}!".colorize(String.colors.sample)
      end
      sleep(1)

      # Adds winnings to user's wallet
      add_winnings(winnings_amount)
    end


    # This method adds the winnings of a single game, to the user's wallet
    def add_winnings(winnings_amount)
      @wallet += winnings_amount
    end


    # Allows the user to play again, or exit
    def repeat_game
      sleep(1)
      puts "\n-----------------------"
      puts "You currently have $#{@wallet} left.".colorize(:blue)
      sleep(1)
      if @wallet <= 0
        sleep(3)
        cash_out
      else
        puts "What would you like to do next?"
        puts "1) Play Again"
        puts "2) Cash Out"
        print "> "
        choice = gets.to_i
        case choice
        when 1
          sleep(1)
          initialize(@player)
        when 2
          puts "Goodbye!"
          sleep(1)
          cash_out
        else
          puts "invalid entry, try again"
          sleep(1)
          repeat_game
        end 
      end     
    end


    # Cashes user out and exits the game
    def cash_out
      player.wallet = @wallet
    end
  end


# Types of bets:
# - red/black
# - odd/even
# - 00
# - 1-12
# - 13-24
# - 25-36
# - 1-18
# - 19-36
class Bet
  attr_accessor :bet_option, :bet_amount
  def initialize(bet_option,bet_amount)
    @bet_option = bet_option
    @bet_amount = bet_amount
  end
end