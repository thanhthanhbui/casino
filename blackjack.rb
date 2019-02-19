class BlackJack
  attr_accessor :player
  def initialize(player)
    @player = player
    @bjmoney = @player.wallet
    bet
  end

  def bet
    puts "Welcome to BlackJack #{@player.name}".colorize(:yellow)
    puts "You have #{@bjmoney} dollars"
    puts "How much would you like to bet? (or bet 0 to return to games menu)"
    @bet = gets.to_i
    if 
      @bet == 0
      back_tomenu
    elsif
      @bet > @bjmoney
      puts "You don't have enough money".colorize(:red)
      puts "---".colorize(:green)
      bet
    else 
      game_start
    end
  end

  def game_start
    @dealerrunning = rand(1..11)
    @playerrunning = rand(1..11)
    game
  end
  
  def game
    puts "---".colorize(:green)
    puts "The dealer's total of flipped cards is:"
    puts "#{@dealerrunning}".colorize(:cyan)
    puts "Your total of flipped cards is:"
    puts "#{@playerrunning}".colorize(:cyan)
    puts "Would you like to add a card (y/n)?"
    newcard = gets.strip.downcase
    if 
      newcard == "y"
      hit
    else
      result
    end
  end

   def result
    finalnumber = @playerrunning
    finalnumberd = @dealerrunning
    if finalnumberd < finalnumber
      finalnumberd = finalnumberd + rand(1..11)
      puts "The dealer turned over 1 more card and totaled #{finalnumberd}"
    else
    end
    case
    when finalnumber == finalnumberd
      puts "Tie".colorize(:yellow)
      bet
    when finalnumber == 21
      puts "YOU WIN!!!".colorize(:green)
        @bjmoney = @bjmoney + @bet
        bet
      when finalnumber > 21
        puts "YOU LOSE!".colorize(:red)
        @bjmoney = @bjmoney - @bet
        bet
      when finalnumberd > 21
        puts "YOU WIN!!!".colorize(:green)
        @bjmoney = @bjmoney + @bet
        bet
      when finalnumberd > finalnumber
        puts "YOU LOSE!".colorize(:red)
        @bjmoney = @bjmoney - @bet
        bet
      when finalnumber > finalnumberd
        puts "YOU WIN!!!".colorize(:green)
        @bjmoney = @bjmoney + @bet
        bet
      else
      end
    end

    def hit
      @playerrunning = @playerrunning + rand(1..11)
      if 
        @dealerrunning < 14
        @dealerrunning = @dealerrunning + rand(1..11)
      else
        @dealerrunning = @dealerrunning
      end
      game
    end
    
    def dealerhit
      if finalnumberd < finalnumber
        finalnumberd = finalnumberd + rand(1..11)
        puts "The dealer turned over 1 more card".colorize(:cyan)
        puts finalnumberd
        dealerhit
      else
      end
    end

    def back_tomenu
      player.wallet = @bjmoney
      puts "Are you sure you want to leave BlackJack?"
      puts "1) Yes".colorize(:green)
      puts "2) No".colorize(:red)
      choice = gets.to_i
      if choice == 1
        puts "Thank you for playing!".colorize(:green)
        sleep(1)
      elsif choice == 2
        puts "---".colorize(:yellow)
        bet
      else
        puts "Invalid selection".colorize(:red)
        back_tomenu
      end

    end

  
end
