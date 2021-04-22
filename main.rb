def play_game
    game_instructions
    sleep(1.0)
end

def run_game
    counter = 12
    randomColours = []
    i = 0

 colourHash = {}
    while i < 4 
      num = rand(0..5)
      
      case num
      when 0
        colorCode = "G"
      when 1
        colorCode = "R"
      when 2
        colorCode = "Y"
      when 3
        colorCode = "B"
      when 4
        colorCode = "P"
      else
        colorCode = "C"
      end
      colourHash[i] = colorCode
      i = i + 1
    end
  
      secretCode = [
        colourHash[0],
        colourHash[1], 
        colourHash[2], 
        colourHash[3], 
      ]

      userWins = false
      puts "\nYou have 12 guesses to guess the secret number!"
      puts "\nEnter first guess: "

      while counter > 0 && userWins == false
        userInput = gets.upcase.chomp.split("")

      if userInput.length == 4 && userInput.all? {|a| a == "G" || a == "R" || a == "Y" ||a == "B" ||a == "P" ||a == "C"} 
        i = 0  
        while i < 4
            
          if userInput[i] == secretCode[i]
              print "\e[91m\u25A0\e[0m "
          elsif userInput.any? { |c| c == secretCode[i] && userInput[i] != secretCode[i]}   
              print "\e[97m\u25A1\e[0m "                    
          end                                               
          i = i + 1
        end
          
        userInput.join("")
        secretCode.join("")
        
        if userInput == secretCode
            puts "\n\nYou Win!"
            print "\n\nThe Secret Code was #{secretCode.join("")}\n"
            userWins = true 
        else
          counter -= 1
          if counter == 0
            puts "\n\nGAME OVER!"
            print "\n\nThe Secret Code was #{secretCode.join("")}\n"
          elsif counter == 1
            puts "\n\nFinal Try!"
          else
            puts "\n\nIncorrect Code. #{counter} guesses remaining"
          end
        end
      else
        puts "\nYou've entered incorrect values!!"
        counter
      end
    end
    play_again
end


def game_instructions
  puts <<-HEREDOC 

    ***** Mastermind *****

    Try to Break the code!

   RULES:

    1. CODEBREAKER:
        The computer randomly selects from a set of six colors
        You have to guess the colors in their correct order before the guesses run out.
        You have a total of twelve guesses.
        Dont worry, hints will be given along the way.

    2. CODEMAKER:
        You set the code from a set of six colors
        The computer will have twelve guesses to get the correct code

    HINTS:

    \e[91m\u25A0\e[0m  means you have a correct guess in the correct order.
    \e[97m\u25A1\e[0m  means you have a correct guess in the incorrect order.


    COLORS:

    \e[102m      \e[0m Green (G)    \e[43m      \e[0m Yellow (Y)    \e[45m      \e[0m Purple (P)
    \e[44m      \e[0m Blue (B)     \e[41m      \e[0m Red (R)       \e[46m      \e[0m Cyan (C)   
    

    Enter 1 for CODEBREAKER
    Enter 2 for CODEMAKER

  HEREDOC

  selection = gets.chomp

  if selection == "1"
    run_game
  elsif selection == "2"
    code_maker
  else
    puts "Invalid response"
  end

end



def code_maker
  puts "Please enter a four code using the letters GRYBPC "
  userCode = gets.upcase.chomp.split("")
  computerGuessCurr = ["G", "G", "R", "R"]
  guessCount = 12
  computerWins = false
  codeArray = ["G","R","Y","B","P","C"]
  computerGuessNext = ["","","",""]

  if userCode.length == 4 && userCode.all? { |a| a == "G" || a == "R" || a == "Y" ||a == "B" ||a == "P" ||a == "C" }  

    while guessCount > 0 && computerWins == false 
      puts "Computer Guesses: #{computerGuessCurr.join("")}"
      sleep(2.0)
      if computerGuessCurr == userCode
        puts "Computer Wins"
        computerWins = true
      else
        i = 0
        while i < 4
          if computerGuessCurr[i] == userCode[i]
            computerGuessNext[i] = computerGuessCurr[i]
          else
            computerGuessNext[i] = codeArray[rand(0..5)]
          end
          i = i + 1
        end
      end
      guessCount = guessCount - 1
      computerGuessCurr = computerGuessNext
    end
  end
  if computerWins == false
    puts "Computer loses!"
    sleep(1.0)
  end
  play_again
end


def play_again
  puts "\nEnter 1 to play again\nEnter 2 to exit"
  userChoice = gets.chomp
  if userChoice == "1"
    play_game 
  elsif userChoice == "2"
    puts "Goodbye"
    sleep(1.0)   
  else userChoice != "1" || userChoice != "2"
    puts "Invalid entry"
    play_again
  end  
end




play_game
