require "pry"
require "colorize"

class Slots
  def initialize(player)
    @player = player
    @wallet_slots = player.wallet
    slots_menu
  end
  def slots_menu
    puts `clear`
    puts "               .               ..       .       .   .             .".colorize(:green)
    puts " .      .     T h i s   i s   t h e   g a l a x y   o f   . . .             .".colorize(:green)
    puts "                     .              .       .                    .      .".colorize(:green)
    puts "               _________________      ____         __________".colorize(:green)
    puts " .       .    X                 |    X    X    .  |          X ".colorize(:green)
    puts "     .       X    ______   _____| . X      X      |    ___    |     .     .".colorize(:green)
    puts "             X    X    |   |       X   XX   X     |   |___>   |".colorize(:green)
    puts "           .  X    X   |   |      X   X__X   X  . |         _X               .".colorize(:green)
    puts " .     ________>    |  |   | .   X            X   |   |X    X_______    .".colorize(:green)
    puts "      |            X   |   |    X    ______    X  |   | X           |".colorize(:green)
    puts "      |___________X    |___|   X____X      X____X |___|  X__________|    .".colorize(:green)
    puts "  .     ____    __  . _____   ____      .  __________   .  _________".colorize(:green)
    puts "       X    X  X  X  X    X  X    X       |          X    X         |      .".colorize(:green)
    puts "        X    XX    XX    X  X      X      |    ___    |  X    ______|  .".colorize(:green)
    puts "         X              X  X   XX   X .   |   |___>   |  X    X ".colorize(:green)
    puts "   .      X            X  X   X__X   X    |         _X.   X    X            +".colorize(:green)
    puts "           X    XX    X  X            X   |   |X    X______>    |   .".colorize(:green)
    puts "            X  X  X  X  X    ______    X  |   | X              X          .".colorize(:green)
    puts " .       .   XX    XX  X____X      X____X |___|  X____________X  LS".colorize(:green)
    puts "                               .                                        .".colorize(:green)
    puts "     .                           .         .               .                 .".colorize(:green)
    sleep(3)
    puts `clear`
    puts "------------------------------------".colorize(:red)
    puts "Hello #{@player.name}!".colorize(:red)
    puts "WELCOME TO JEDI ACADEMY SLOT MACHINE!".colorize(:red)
    puts "1) Start a new game".colorize(:green)
    puts "2) Additional Options".colorize(:green)
    puts "3) Quit".colorize(:green)
    choice = gets.to_i
    case choice
    when 1
      puts `clear`
      slots_game
    when 2
      puts `clear`
      return_main_menu
    when 3
      puts `clear`
      puts "<(-_-)> May the Force be with you.".colorize(:green)
      sleep(3)
      puts `clear`
      exit
    else
      puts "Invalid choice. Try again!".colorize(:red)
      sleep(1)
      puts `clear`
      slots_menu
    end
  end

  def slots_game
    if @wallet_slots > 0
      puts "<(-_-)> The fear of loss is a path to the Dark Side.".colorize(:green)
      sleep(1)
      puts "You have $#{@wallet_slots}.".colorize(:red)
      puts "Place your bet (min $1): ".colorize(:red)
      @slots_bet = gets.to_i
      if @slots_bet > @wallet_slots
        puts "You only have $#{@wallet_slots}.".colorize(:red)
        puts "Please choose:".colorize(:red)
        puts "1) Place lower bet".colorize(:green)
        puts "2) Additional Options".colorize(:green)
        choice = gets.to_i
        case choice
        when 1
          puts `clear`
          slots_game
        when 2
          puts `clear`
          return_main_menu
        else
          puts "Invalid choice. Try again".colorize(:red)
          sleep(1)
          puts `clear`
          slots_menu
        end
      elsif @slots_bet == 0
        puts "The minimum must be $1. Try again.".colorize(:red)
        slots_game
      else
        sleep(1)
        puts "Spinning...".colorize(:blue)
        sleep(2)
        puts "Still spinning...".colorize(:blue)
        sleep(2)
        puts "<(-_-)> PATIENCE YOU MUST HAVE my young padawan!".colorize(:green)
        sleep(2)
        reel_spinning
        sleep(2)
        if @result1 == @result2
          possible_win
        else
          lose
        end
        sleep(1)
        sub_menu
      end
    else
      puts "You don't have enough money.".colorize(:red)
      sleep(1)
      return_main_menu
    end
  end

  def possible_win
    if @result1 == @result3
      win
    else
      lose
    end
  end

  def reel_spinning
    @result1 = rand(1..5).to_i
    @result2 = rand(1..5).to_i
    @result3 = rand(1..5).to_i
    puts "Your reels landed on #{@result1} - #{@result2} - #{@result3}.".colorize(:yellow)
  end

  def win
    @wallet_slots += @slots_bet * 3
    puts "YOU WIN!!!".colorize(:red)
    sleep(1)
    puts "<(-_-)> If you end your training now,".colorize(:green)
    sleep(2)
    puts "if you choose the quick and easy path as Vader did,".colorize(:green)
    sleep(2)
    puts "you will become an agent of evil.".colorize(:green)
    sleep(2)
    puts "Your wallet now has $#{@wallet_slots}.".colorize(:red)
  end

  def lose
    @wallet_slots -= @slots_bet
    puts "YOU LOSE!!!".colorize(:red)
    sleep(1)
    puts "<(-_-)> The greatest teacher, failure is.".colorize(:green)
    sleep(1)
    puts "Your wallet now has $#{@wallet_slots}.".colorize(:red)
  end

  def sub_menu
    puts "-----------------".colorize(:red)
    puts "Would you like to".colorize(:red)
    puts "1) Play again".colorize(:green)
    puts "2) Additional Options".colorize(:green)
    choice = gets.to_i
    case choice
      when 1
        puts `clear`
        slots_game
      when 2
        puts `clear`
        return_main_menu
      else
        puts "Invalid choice. Try again".colorize(:red)
        sleep(1)
        puts `clear`
        slots_menu
    end
  end

  def return_main_menu
    @player.wallet = @wallet_slots
  end

end
