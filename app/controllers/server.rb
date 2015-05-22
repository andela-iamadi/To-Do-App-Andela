require 'sinatra/base'
require 'sinatra/reloader'

class Server

	configure :development do
		register Sinatra::Reloader
	end

	get '/' do
		redirect '/task'
	end

  	get('/style.css'){ scss :style }
	get('/login_style.css'){ scss :login_style }

	not_found do 
		@title = "Sorry, couldn't find that request"
		erb :not_found
	end
end