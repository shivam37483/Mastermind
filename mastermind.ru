class MasterMind
    @@turn_count = 0
    @@user_array = Array.new(4)
    @@winner = ""
    @@winning_comp_a_maker = ["0","0","0","0"]


    RANGE = ['1','2','3','4','5','6']
    
    def initialize
        puts "Welcome to Mastermind!"
        puts "Enter your name"
        @name = gets
        
        puts "Enter 1 for Code maker OR 2 for Code breaker"
        @user =  gets.chomp.to_i
        unless @user == 1 || @user == 2
            puts "Select a valid choice!"
            initialize
        end  
        
        @@answer_maker = generate_code_breaker
        # puts "Answer: #{@@answer_maker}"
    end
    
    def generate_code_breaker        
        i = 1
        @random_code_breaker = []
        # puts   "Before RAndom code #{@random_code_breaker} "
        
        while i <= 4 do
            value = RANGE.sample
            @random_code_breaker.push(value)
            i += 1
        end
        
        # puts   "RAndom code #{@random_code_breaker} "
        return @random_code_breaker
    end
    
    
    def user_guess_breaker
        puts "Enter your guess"
        @user_guess = gets.chomp       
        
        unless @user_guess.length == 4 
            puts "Invalid guess enter again"
            user_guess_breaker
        end
        
        @@user_array = @user_guess.split("")
    end

    def game_logic_breaker          
        
         for i in 0...4 do
            m=0
            for j in 0...4 do
               if @@user_array[j] == @@answer_maker[i]
                    if i == j
                        m = 1
        
                    elsif i != j
                        m += 2  
                    end        
               end
            end
        
            if m.odd?
                puts "red light at position #{i+1}"
                
            elsif m == 0
                puts "no match"
        
            elsif  m.even? 
                puts "White light at position #{i+1}"
            end
        end
        
    end

    def winning_logic_breaker
        if @@answer_maker == @@user_array
            @@turn_count = 12
            puts "Congratulations #{@name} u won!!"
        elsif @@turn_count == 12
            puts "You lose!"
        else
          puts "Turn: #{@@turn_count+1}"
            @@turn_count += 1
        end
    end

    # For choice 2

    def generate_code_maker
        puts "Enter your SECRET code"
        @user_computer = gets.chomp

        unless @user_computer.length == 4
            puts "Select a valid choice!"
            generate_code_maker
        end 

        @@user_array = @user_computer.split("")
    end

    def comp_guess
        @comp_array = []

        i = 1
        while i <= 4 do
          value = RANGE.sample
          @comp_array.push(value)
          i += 1
        
        end        
        print @comp_array 
        puts ""

       return @comp_array
    end

    def game_logic_maker
        4.times do |i|
            if @@user_array[i] == @comp_array[i]
                @@winning_comp_a_maker[i] = @comp_array[i]
                puts "Red light at #{i+1} position"
            end

        end
    end

    def winning_logic_maker
        if @@winning_comp_a_maker == @@user_array
            print @@winning_comp_a_maker
            puts ""
            puts "Computer Won!!"
            # print @@user_array
            puts ""
            @@turn_count = 13
            
        elsif @@turn_count == 12 && @@winning_comp_a_maker != @@user_array
            puts "Congo u won #{@name}!!!!"
            @@turn_count = 13

        else
          puts "Turn: #{@@turn_count+1}"
            @@turn_count += 1
        end        
    end

    def play_game
        if @user == 1
        puts "Code has been generated!" 
          
            until @@turn_count >= 12 do 
                user_guess_breaker
                game_logic_breaker
                winning_logic_breaker
            end
            
        elsif @user == 2
            generate_code_maker
            until @@turn_count > 12
                comp_guess
                game_logic_maker
                winning_logic_maker                
            end

        end
    end
end

one = MasterMind.new
one.play_game