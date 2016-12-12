require 'sinatra'

get '/' do 
	@display_text = "This is my display text from the .rb file."
	@friends = ["Harry", "Sally", "Mister", "Moon"]
	erb :home
end

get '/about' do 
	erb :about
end

post '/contact' do
  @name = params[:name].upcase
  @email = params[:email]
  @message = params[:message]
  erb :contact
  # redirect '/'
end