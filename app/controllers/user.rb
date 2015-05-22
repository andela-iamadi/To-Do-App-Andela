
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sass'
require 'json'


class UserController < Server

	get '/login/?' do
		if session[:username] == "" || session[:username] == nil
			@page_title = "Login"
			@username = params[:username]
			@message = params[:message]
			erb :login, :layout => :auth_layout
		else
			redirect '/'
		end
	end

	get '/signup' do
		if session[:username] == "" || session[:username] == nil
			@username = params[:username]
			@message = params[:message]
			erb :login, :layout => :auth_layout
		else
			redirect '/'
		end
	end

	post '/login' do
		@users = User.first(:conditions => {:username => params[:username], :password => params[:password]})
		if @users != nil
			session[:username] = params[:username]
			puts "Logged in"
			#session[:password] = params[:password]
			redirect '/'
		else
			redirect "/user/login?username=#{params[:username]}&message=Wrong%20username%20or%20password."
		end
	end

	post '/signup' do
		save = User.create(:email => params[:email], :username => params[:username], :password => params[:password], :created => Time.now)
		if (save.save) 
			redirect "/user/login?username=#{params[:username]}&message=User%20created%20successfully%20..."
		else
			redirect "/user/login?username=#{params[:username]}&message=Wrong%20username%20or%20password."
		end
	end
end