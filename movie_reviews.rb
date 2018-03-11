require 'yaml'
# YAML code from https://stackoverflow.com/questions/30718214/saving-hashes-to-file-on-ruby
movies = Hash.new

File.write('movies.yaml', movies.to_yaml) unless File.exist?("movies.yaml")


 # read back in from file
 movies_file = YAML.load_file('movies.yaml')

loop do
  puts "What would you like to do?"
  puts "- 'add' a movie"
  puts "- 'update' a movie"
  puts "- 'display' all movies"
  puts "- 'delete' a movie"
  puts "- 'exit' the program"
  choice = gets.chomp.downcase



  case choice
    when "add"
      puts
      puts "What movie would you like to add?"
      title = gets.chomp
      if movies_file[title.to_sym] == nil
        puts
        puts "How would you rate this movie? (1-5)"
        rating = gets.chomp
        movies_file[title.to_sym] = rating.to_i
        #YAML.dump code from https://stackoverflow.com/questions/13948951/update-value-of-key-of-a-yaml-file-in-ruby-on-rails?rq=1
        File.open("movies.yaml", 'w') { |f| YAML.dump(movies_file, f) }
        puts
        puts "#{title} added with a #{rating} star rating."
        puts
      else
        puts
        puts "This title already exists."
        puts
      end
      
    when "update"
      puts
      puts "What movie would you like to update?"
      title = gets.chomp
      if movies_file[title.to_sym] == nil
        puts
        puts "Oops, looks like that movie isn't here."
        puts
      else
        puts
        puts "What's the new rating?"
        rating = gets.chomp
        movies_file[title.to_sym] = rating.to_i
        File.open("movies.yaml", 'w') { |f| YAML.dump(movies_file, f) }
        puts
        puts "#{title} updated with a #{rating} star rating."
        puts
      end
    when "display"
      puts
      movies_file.each { |movie, rating| 
        puts "#{movie}: #{rating}" 
        }
      puts
    when "delete"
      puts
      puts "What movie would you like to delete?"
      title = gets.chomp
      if movies_file[title.to_sym] == nil
        puts
        puts "Hmm, can't delete what's not here!"
        puts
      else
        movies_file.delete(title.to_sym)
        File.open("movies.yaml", 'w') { |f| YAML.dump(movies_file, f) }
        puts
        puts "#{title} deleted!"
        puts
      end
    when "exit"
      exit
    else 
      puts
      puts "That is not a valid option."
      puts
  end 
end