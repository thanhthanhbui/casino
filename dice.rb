require "pry"
require "colorize"

class Dice
  attr_accessor :player

  def initialize(player)
    @player = player
    @wallet_dice = player.wallet
    dice_table
  end

  def dice_table
    puts "You have $#{@wallet_dice}.".colorize(:cyan)
    puts "1) Bet".colorize(:cyan)
    puts "2) Cashout".colorize(:cyan)
    selection = gets.to_i
    if selection == 1
      dice_bet
    elsif selection == 2
      cash_out
    else
      puts "Invalid selection.".colorize(:red)
      puts ""
      dice_table
    end
  end

  def dice_bet
    puts `clear`
    puts "You have $#{@wallet_dice} to bet.".colorize(:cyan)
    puts "How much would you like to bet?".colorize(:cyan)
    @bet = gets.to_i
    if @bet == 0
      dice_bet
    elsif @bet > @wallet_dice
      puts "You don't have that much money!".colorize(:red)
      puts ""
      dice_table
    else
      @wallet_dice = @wallet_dice - @bet
      dice_roll
    end
  end

  def dice_game
    puts "Other players rolled #{@opponent_dice}".colorize(:magenta)
    puts "You rolled #{@playerdice}".colorize(:yellow)
    puts ""
    sleep (1)
    if @playerdice > @opponent_dice.max
      puts "You won!".colorize(:yellow)
      @wallet_dice = @wallet_dice + (@bet * 4)
      sleep (1)
      puts ""
      dice_table
    elsif @playerdice < @opponent_dice.max
      puts "You lost.".colorize(:red)
      sleep (1)
      puts ""
      dice_table
    else @playerdice = @opponent_dice.max 
      reroll
    end
  end

  def reroll
    puts ""
    puts "Reroll between the two highest!".colorize(:cyan)
    playerdice = 1 + rand(6)
    opponentdice = 1 + rand(6)
    puts "Your opponent rolled #{opponentdice}".colorize(:magenta)
    puts "You rolled #{playerdice}".colorize(:yellow)
    sleep (1)
    if playerdice > opponentdice
      puts "You won!".colorize(:yellow)
      @wallet_dice = @wallet_dice + (@bet * 4)

      sleep (1)
      puts ""
      dice_table
    elsif playerdice < opponentdice
      puts "You lost.".colorize(:red)
      sleep (1)
      puts ""
      dice_table
    else playerdice = opponentdice
      reroll
    end
  end

  def cash_out
    player.wallet = @wallet_dice
  end

  def dice_roll
    @opponent_dice = [
      @dice1 = 1 + rand(6),
      @dice2 = 1 + rand(6),
      @dice3 = 1 + rand(6)
  ]

    @playerdice = 1 + rand(6)

    dice_game
  end
end