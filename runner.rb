require 'unirest'

while true
system 'clear'

  puts "Welcome to Digital Media"
  puts "please select an option"
  puts "  [1] Display all movie"
  puts "  [1.1] Search a movie by name"
  puts "  [2] Search a movie by Id"
  puts "  [3] create a movie"
  puts "  [4] Update a movie"
  puts "  [5] Delete a movie"
  puts "  [register] Register a user"
  puts "  [login] Log in"
  puts "  [logout] Log out" 
  puts "  [q] Quit the Digital Media"

input_option = gets.chomp

 if input_option == "1"
    response = Unirest.get("http://localhost:3000/movies")
    movies = response.body
    puts JSON.pretty_generate(movies)
elsif input_option == "1.1"
    print "Enter a movie name: "
    search_term = gets.chomp
    response = Unirest.get("http://localhost:3000/movies?search=#{search_term}")
    movies = response.body
    puts JSON.pretty_generate(movies)
elsif input_option == "2"  
      puts "Search by a Movie id"
      input_id = gets.chomp
      response = Unirest.get("http://localhost:3000/movies/#{input_id}")
      movies = response.body
      puts JSON.pretty_generate(movies)

      puts "Press Enter to continue or type [w] to add the watchlist"
      user_choice = gets.chomp
      if user_choice === 'w'
          client_params = {
                            movie_id: input_id
                          }
        json_data = Unirest.post("http://localhost:3000/watchlists", parameters: client_params).body
        puts JSON.pretty_generate(json_data)
      end 
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

  print "Image url:-"
  client_params[:image_url] = gets.chomp

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
elsif input_option =="register"
      puts "Register for New User"
      puts
      client_params = {}
      print "First Name: "
      client_params[:first_name] = gets.chomp

      print "Last Name: "
      client_params[:last_name] = gets.chomp

         print "Email: "
         client_params[:email] = gets.chomp

         print "Password: "
         client_params[:password] = gets.chomp

          print "Password Confirmation: "
         client_params[:password_confirmation] = gets.chomp

        response = Unirest.post(
                           "http://localhost:3000/users",
                             parameters: client_params
                             )
        puts response.body
elsif input_option == "login"
      puts "Login"
      puts 
      print "Email: "
      input_email = gets.chomp

      print "Password: "
      input_password = gets.chomp

      response = Unirest.post("http://localhost:3000/user_token", 
                                                    parameters:{
                                                          auth: {email:input_email, password:input_password}
                                                        }
                                                     )
      puts JSON.pretty_generate(response.body)
      jwt = response.body["jwt"]
      Unirest.default_header("Authorization", "Bearer #{jwt}")
elsif input_option == "logout"
      jwt = ""
      Unirest.clear_default_headers
elsif input_option == "q"
  puts "Thank you for visiting the Digital Media"
  exit
end
  gets.chomp
end

    
  























