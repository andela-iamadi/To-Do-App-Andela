

class NotificationController < Server
	get '/new' do
		@title = "Add todo task"
		erb :new_task
	end

	get '/track_data' do
	tasks = "";
		@tasks = Notification.all(:order => :created.desc, :conditions => {:created_by => session[:username]})
		@tasks.each do |task|
		     tasks += "<div class='sidebar_task'>"\
				"<h4><i class='fa fa-calendar fa-6'></i>#{task.created.strftime("%e %B %Y")}</h4>"\
		        "<p>#{task.message}</p>"\
			      "<a href='#'><i>View</i></a>"\
		      "</div><!--close sidebar_task--> ";
		end
		tasks 
	end

	post '/new' do
		@username = session[:username]
		puts "start putting notification from #{@username}. Message: #{params[:message]}"
		note = Notification.create(:message => params[:message], \
		 				:created_by => @username, :created => Time.now)
		{:id => params[:id], :content => params[:message], :created => Time.now.strftime("%e %B %Y") }.to_json
	end

	post '/viewed' do
		task = Notification.first(:id => params[:id])
		task.viewed = true
		content_type 'application/json'
		value = task.save;
		value
	end


	get '/delete/:id' do
		@task = Notification.first(:id => params[:id])
		task = Task.first(:id => params[:id])
		task.destroy
		redirect '/'
	end

	post '/delete/:id' do
		@task = Notification.first(:id => params[:id])
		task = Task.first(:id => params[:id])
		task.destroy
		redirect '/'
	end
end