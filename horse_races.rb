require "pry"
class HorseRaces

    def initialize(player)
        @player = player
        @wallet_horses = player.wallet
        @horse_names = ["Secratariat", "Man o' War", "California Chrome", "Preakness", "Seattle Slew", "Whirlaway", "Lord Murphy", "Vagrant", "Pink Star", "Typhoon II", "Joe Cotton", "Sir Barton", "Thunder Gulch"]  
        puts "-----------------------".colorize(:blue)
        puts "Welcome to the Horse Races, #{@player.name}!".colorize(:blue)
        puts "You have #{@wallet_horses} to bet with today".colorize(:blue)
        puts "-----------------------".colorize(:blue)
        puts 
        rand(1) == 0 ? select_horse : random_event
    end

    def random_event
        if rand(1) == 0
            puts "You found $5 on the ground! 💰".colorize(:green)
            @wallet_horses += 5
            puts "You have #{@wallet_horses} to bet with"
            puts
        else
            puts "You decide to go to the bar before playing 🍸".colorize(:red)
            @wallet_horses -= 5
            puts "You have #{@wallet_horses} to bet with"
            puts
        end
        select_horse
    end

    def select_horse
        puts "Here are the horses in the upcoming race".colorize(:blue) 
        puts "Input the number of the horse to select one: ".colorize(:blue)
        puts "-----------------------".colorize(:blue)
        @racing_horses = @horse_names.sample(6)
        @racing_horses.each_with_index do |horse, index|
            puts "#{index + 1}) #{horse}".colorize(:blue)
        end
        puts "-----------------------".colorize(:blue)
        print "> "
        choice = gets.to_i
        if choice < 7
            @selected_horse = @racing_horses[choice - 1]
            betting
        else 
            puts "Invalid Choice"
            select_horse
        end
    end

    def betting
        puts "Would you like to bet that #{@selected_horse} will:".colorize(:blue)
        puts "-----------------------".colorize(:blue)
        puts "1) Win (3 : 1 odds)".colorize(:blue)
        puts "2) Place (2 : 1 odds)".colorize(:blue) 
        puts "3) Show (1 : 1 odds)".colorize(:blue)
        puts "-----------------------".colorize(:blue)
        print "> "
        choice = gets.to_i
        case choice 
        when 1
            @odds = 3
        when 2 
            @odds = 2
        when 3
            @odds = 1
        else
            puts "Invalid choice"
            betting
        end
        puts "Now, how much do you want to bet? Our minimum bet is $1"
        print "> "
        bet = gets.to_i
        race(bet)
    end

    def race(bet)
        @winning_horse = @racing_horses.sample
        puts "And they're off!"
        horse_pic =  "🏇"

        6.times do |x|
            puts horse_pic.prepend("=").colorize(:green)
            sleep(0.5)
        end
        if @selected_horse == @winning_horse
            @wallet_horses += bet * @odds
            puts "You won!".colorize(:green)
            puts "You have #{@wallet_horses} left to bet with"
            menu_two
        else
            @wallet_horses -= bet
            puts "You lose!".colorize(:red)
            puts "You have $#{@wallet_horses} left to bet with"
            menu_two
        end
    end

    def menu_two 
        puts "Would you like to".colorize(:blue)
        puts "-----------------------".colorize(:blue)
        puts "1) Play again".colorize(:blue)
        puts "2) Return to casino".colorize(:blue)
        puts "-----------------------".colorize(:blue)
        print "> "
        choice = gets.strip.to_i
        case choice
        when 1
            if @wallet_horses > 0
                select_horse
            else
                puts "You don't have enough money to bet"
                return_to_casino
            end
        when 2
            return_to_casino
        else
            puts "Invalid Entry"
            menu_two
        end
    end

    def return_to_casino 
        @player.wallet = @wallet_horses
    end

end





