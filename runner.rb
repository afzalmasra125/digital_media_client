require 'unirest'

system 'clear'



    puts "Enter information for a new movie"
    client_params = {}

    print "Movie Name: "
      client_params[:name] = gets.chomp

     print "Summary"

    client_params[:summary] = gets.chomp

    print "Actor: "
    client_params[:actor] = gets.chomp

     print "Rating: "
     client_params[:rating] = gets.chomp

     print "Genre: "
     client_params[:genre] = gets.chomp

     p client_params

     response = Unirest.post(
                           "http://localhost:3000/movies",
                             parameters: client_params
                             )

      movies = response.body
      puts JSON.pretty_generate(movies)

    # if response.code == 200
    #   movies = response.body
    #   puts JSON.pretty_generate(movies)
    # else
    #   errors = response.body["errors"]
    #   puts
    #   puts "Your movie did not save"
    #   puts "please look at the following reasons"
    #   puts "------------------------------------"
    #   errors.each do |error|
    #     puts error
    #   end
  #   end
  # end

  print "Enter a movie id: "
    input_id = gets.chomp

    response = Unirest.get("http://localhost:3000/movies/#{input_id}")
    movie = response.body

    puts "Enter new information for movie ##{input_id}"
    client_params = {}

    print "First Name (#{movie["first_name"]}): "
    client_params[:first_name] = gets.chomp

    print "Middle Name (#{movie["middle_name"]}): "
    client_params[:middle_name] = gets.chomp

    print "Last Name (#{movie["last_name"]}): "
    client_params[:last_name] = gets.chomp

    print "Email (#{movie["email"]}): "
    client_params[:email] = gets.chomp

    print "Bio (#{movie["bio"]}): "
    client_params[:bio] = gets.chomp

    print "Phone Number (#{movie["phone_number"]}): "
    client_params[:phone_number] = gets.chomp

    client_params.delete_if {|key, value| value.empty? }

    response = Unirest.patch(
                            "http://localhost:3000/movies/#{input_id}",
                            parameters: client_params
                            )

    if response.code == 200
      movie = response.body
      puts JSON.pretty_generate(movie)
    else
      errors = response.body["errors"]
      puts
      puts "Your movie did not update"
      puts "please look at the following reasons"
      puts "------------------------------------"
      errors.each do |error|
        puts error
      end
    end
  end
