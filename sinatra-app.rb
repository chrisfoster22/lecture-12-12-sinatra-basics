require 'sinatra'
require 'sendgrid-ruby'
require 'sinatra/activerecord'
require './models'

set :database, "sqlite3:test.sqlite3"

get '/' do
	@user = User.find(1)
	@display_text = "This is my display text from the .rb file."
	@friends = ["Harry", "Sally", "Mister", "Moon"]
	erb :home
end

get '/users' do
	@users = User.all
	erb :users
end

get '/about' do 
	erb :about
end

post '/contact' do
	@name = params[:name]
	@email = params[:email]
	@subject = params[:subject]
	@message = params[:message]
  
  	from = SendGrid::Email.new(email: @email)
	subject = @subject
	to = SendGrid::Email.new(email: 'chris.foster@nycda.com')

	content = SendGrid::Content.new(type: 'text/plain', value: @message)

	mail = SendGrid::Mail.new(from, subject, to, content)

	sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

	response = sg.client.mail._('send').post(request_body: mail.to_json)

	puts response.status_code
	puts response.body

	erb :contact

end