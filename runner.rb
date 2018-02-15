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
    #   puts "Your contact did not save"
    #   puts "please look at the following reasons"
    #   puts "------------------------------------"
    #   errors.each do |error|
    #     puts error
    #   end
  #   end
  # end