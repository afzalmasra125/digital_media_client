require 'unirest'

system 'clear'

  puts "Welcome to Digital Media"
  puts "please select an option"
  puts "  [1] Display all movie"
  puts "  [2] Search a movie"
  puts "  [3] create a movie"
  puts "  [4] Update a movie"
  puts "  [5] Delete a movie"

input_option = gets.chomp

 if input_option == "1"
    response = Unirest.get("http://localhost:3000/movies")
    movies = response.body
    puts JSON.pretty_generate(movies)
elsif input_option == "2"  
      puts "Search by a Movie id"
      input_id = gets.chomp
      response = Unirest.get("http://localhost:3000/movies/#{input_id}")
      movies = response.body
      puts JSON.pretty_generate(movies)
elsif input_option == "3"
    puts "Enter information for a new movie"
    client_params = {}

    print "Movie Name:- "
      client_params[:name] = gets.chomp

     print "Summary:-"

    client_params[:summary] = gets.chomp

    print "Actor:- "
    client_params[:actor] = gets.chomp

     print "Rating:- "
     client_params[:rating] = gets.chomp

     print "Genre:- "
     client_params[:genre] = gets.chomp

     print "Content url:- "
     client_params[:content_url] = gets.chomp

     response = Unirest.post(
                           "http://localhost:3000/movies",
                             parameters: client_params
                             )

      movies = response.body
      puts JSON.pretty_generate(movies)
  elsif input_option == "4"
    print "Enter a movie id: "
    input_id = gets.chomp

    response = Unirest.get("http://localhost:3000/movies/#{input_id}")
    movie = response.body

    puts "Enter new information for movie ##{input_id}"
    client_params = {}

    print "Movie Name (#{movie["name"]}): "
    client_params[:name] = gets.chomp

    print "Summary (#{movie["summary"]}): "
    client_params[:summary] = gets.chomp

    print "Actor (#{movie["actor"]}): "
    client_params[:actor] = gets.chomp

    print "Rating (#{movie["rating"]}): "
    client_params[:rating] = gets.chomp

    print "Genre (#{movie["genre"]}): "
    client_params[:genre] = gets.chomp

    print "content url (#{movie["content_url"]}): "
    client_params[:content_url] = gets.chomp

    client_params.delete_if {|key, value| value.empty? }

    response = Unirest.patch(
                            "http://localhost:3000/movies/#{input_id}",
                            parameters: client_params
                            )
      movies = response.body
      puts JSON.pretty_generate(movies)

    elsif input_option == "5"
      print "Enter a movie id: "
      input_id = gets.chomp
      response = Unirest.delete("http://localhost:3000/movies/#{input_id}")
      movie = response.body
      puts movie["message"]
    end
  
