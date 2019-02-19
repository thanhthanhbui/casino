require "pry"
require "colorize"

require_relative "roulette"
require_relative "dice"
require_relative "player"
require_relative "horse_races"
require_relative "slots"
require_relative "blackjack"

    # Requirements for every game:
    # - Don't let the user keep playing if they are out of money
    # - Must return the current wallet amount (int)
    # - Minimum bet is $1
    # - Constantly display wallet amount, each round of the game
class Casino
  def initialize
    # Welcome Message
    # Get Input - user name & wallet amount
    get_user_input

    # Display Menu and receive input:
    # List out the individual games (each is a class)
    display_main_menu

    # At the end, the application loops back through the menus for continual playing
    # It also allows the user to exit the application if they want to
  end


  #
  def get_user_input
    puts "Welcome to Money City!".colorize(:red)
    puts "What is your name?".colorize(:blue)
    print "> "
    @name = gets.strip
    puts "How much money do you want to add to your wallet today?".colorize(:blue)
    print "> $"
    @wallet = gets.to_i
    @player = Player.new(@name, @wallet)
    puts "\nGreat, let's get started!".colorize(:yellow)

    sleep(1)
  end


  # Requirements for every game:
  # - Don't let the user keep playing if they are out of money
  # - Must return the current wallet amount (int)
  # - Minimum bet is $1
  # - Constantly display wallet amount, each round of the game
  def display_main_menu
    puts "\nMain Menu".colorize(:red)
    puts "-----------------------".colorize(:blue)
    puts "You currently have $#{@player.wallet}".colorize(:red)
    puts "Please select one of the following:".colorize(:red)
    puts "1)Roulette".colorize(:blue)
    puts "2)Black Jack".colorize(:blue)
    puts "3)Slots".colorize(:blue)
    puts "4)Dice".colorize(:blue)
    puts "5)Horse Races".colorize(:blue)
    puts "6)Additional Options".colorize(:blue)
    puts "-----------------------".colorize(:blue)
    print "> "
    choice = gets.to_i
    case choice
    when 1 # Roulette
      Roulette.new(@player)
    when 2 # Black Jack
      BlackJack.new(@player)
    when 3 # Slots
      Slots.new(@player)
    when 4 # Dice
      Dice.new(@player)
    when 5 # Horse Races
      HorseRaces.new(@player)
    when 6
      repeat_menu
    else
      puts "Invalid input, try again.".colorize(:red)
      sleep(1)
      display_main_menu
    end
    print `clear`
    repeat_menu
  end

  
  # Print out final wallet amount after each game 
  # Allow user to add more money into the wallet
  # Allow user to play a new game
  # allow user to exit the application
  def repeat_menu
    puts "\n-----------------------".colorize(:blue)
    puts "You currently have $#{@player.wallet} left.".colorize(:red)
    puts "What do you want to do?".colorize(:red)
    puts "1)Add more money to my wallet".colorize(:blue)
    puts "2)Play another game".colorize(:blue)
    puts "3)Exit".colorize(:blue)
    puts "-----------------------".colorize(:blue)
    print "> "
    choice = gets.to_i
    case choice
    when 1
      add_money_to_wallet
      display_main_menu
    when 2
      display_main_menu
    when 3
      puts "\nGOOD BYE!!!".colorize(:red)
      sleep(1)
      print `clear`
      exit
    else
      puts "Invalid Entry".colorize(:red)
      repeat_menu
    end
  end


  # Allows the user to add any amount of money (integer)
  # to their wallet for future games.
  def add_money_to_wallet
    puts "\n-----------------------".colorize(:blue)
    puts "How much more money do you want to add?".colorize(:red)
    print "> $"
    new_money = gets.to_i
    @player.wallet += new_money
    puts "Your wallet now has: $#{@player.wallet}".colorize(:blue)
  end
end

Casino.new
