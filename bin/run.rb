require_relative '../config/environment'
require 'pry'
$array = []

def welcome
    logo = "
     ____  _____  ______        _          ___               _          
    |_   \\|_   _||_   _ \\      / \\       .'   `.            (_)         
      |   \\ | |    | |_) |    / _ \\     /  .-.  \\  __   _   __   ____   
      | |\\ \\| |    |  __'.   / ___ \\    | |   | | [  | | | [  | [_   ]  
     _| |_\\   |_  _| |__) |_/ /   \\ \\_  \\  `-'  \\_ | \\_/ |, | |  .' /_  
    |_____|\\____||_______/|____| |____|  `.___.\\__|'.__.'_/[___][_____] "
    puts logo
    $logged_in = ""
    puts "===================================================================================================="
    puts "Welcome top the NBA Quiz!!!!"
end
def get_input
    puts "1. Login"
    puts "2. Create Account"
    puts "3. Delete Account"
    puts "Please enter 1, 2, or 3."
    input = gets.chomp.to_i
    if input == 1
        login
    elsif input == 2
        create_account
    elsif input == 3
        delete_account
    else 
        get_input
    end
end
def login
    puts "Please enter your name."
    name = gets.chomp.to_s
    if User.find_by(name: name)
        current = User.find_by(name: name)
        $logged_in = current.name
    else
        puts "That user does not exist"
        create_account
    end
end
def create_account
    puts "To create an account, please enter your name."
    name = gets.chomp.to_s
    if User.find_by(name: name)
        puts "Sorry that name is taken."
        create_account
    else
        User.create(name: name)
        puts "Thanks for creating an account."
        current = User.find_by(name: name)
        $logged_in = current.name
    end
end
def delete_account
    puts "Enter your account name."
    name = gets.chomp.to_s
    if User.find_by(name: name)
        User.find_by(name: name).destroy
        puts "Your account has been deleted. We hope to see you again!"
        get_input
    else
        puts "That user does not exist."
        get_input
    end
end
def log
    puts "==================================================="
    puts "Use control + c to exit game at any time."
    puts "Instructions: Enter the answer you think is correct."
    puts "==================================================="
end
def increment_questions
    i = 1
    while 10 >= i
        question1(i)
        i += 1
    end
end
def question1(i)
    puts "==================================================="    
    question = Question.find(i)
    puts question.question
    puts answers1(i)[0].answer
    puts answers1(i)[1].answer
    puts answers1(i)[2].answer
    puts answers1(i)[3].answer
    puts "==================================================="
    input = gets.chomp.to_s
    $array << input
end
def answers1(i)
    Answer.where("question_id = '#{i}'")
end

def score
    correct_array = ["11", "1", "16", "6", "81", "63", "Boston Celtics", "Charlotte Hornets", "Tim Duncan", "John Stockton", 0]
    i = 0
    user_score = 0
    while 10 > i
       if correct_array[i] ==  $array[i]
            user_score += 1
       end
       i += 1
    end
    user_score
end
def presents_score(ten)
    if ten == 10
        puts "Hall of Fame!!!"
        puts "10/10"
    elsif ten >= 7 && 9 >= ten
        puts "All Star!!!"
        puts "#{ten}/10"
    else
        puts "Good Job."
        puts "#{ten}/10"
    end
end
def save_score(ten)
    user_id = User.find_by(name: $logged_in).id
    Score.create(score: ten, user_id: user_id)
end
def end_of_game
    puts "Please select a number."
    puts "1. End game."
    puts "2. Find scores by name."
    input = gets.chomp.to_i
    if input == 1
        puts "================================================="
        puts "Thanks for playing! BTW Go Lakers!"
    elsif input == 2
        get_scores
    else
        puts "================================================="
        puts "Please select 1 or 2."
        puts "================================================="
        end_of_game
    end
end
def get_scores
    puts "Please enter the person's name whose score you want to lookup."
    input = gets.chomp.to_s
    
    if User.find_by(name: input)
         u = User.find_by(name: input).id
    else
        puts "Sorry, that user doesn't exist."
        end_of_game
    end
    puts "================================================="
    puts "This user's scores are..."
    puts "================================================="
    use = Score.where("user_id = '#{u}'")
    that = use.map {|score| score.score}
    puts that
    puts "================================================="
    end_of_game
end
def run
    welcome
    get_input
    log
    increment_questions
    ten = score
    presents_score(ten)
    save_score(ten)
    end_of_game
end

run
