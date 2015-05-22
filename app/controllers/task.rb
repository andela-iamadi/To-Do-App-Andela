

class TaskController < Server

	get '/' do 
		if session[:username] == "" || session[:username] == nil
			redirect '/user/login'
		end
		$username = session[:username];
		@password = "";
		@tasks = ""
		@error_message = params[:error_message]
		@success_message = params[:success_message]
		@reminder_msg = params[:reminder_msg]
		@reminder_time = params[:reminder_time]
		@tasks = Task.all(:order => :priority.desc)
		$task_count = Task.count;
		$pending = Task.count(:done => false)
		$completed = $task_count.to_i - $pending.to_i
		@page_title = "Tasks"
		@content_title = "All tasks on my list"
		@title = ""
		redirect '/new' if @tasks.empty? || @tasks.nil?
		erb :index
	end

	get '/new' do
		@page_title = "New_task"
		@content_title = "Add a task"
		@title = "Add todo task"
		erb :new_task
	end

	get '/task/?' do
		if session[:username] == "" || session[:username] == nil
			redirect '/user/login'
		end
		$username = session[:username];
		@password = "";
		@tasks = ""
		@error_message = params[:error_message]
		@success_message = params[:success_message]
		@reminder_msg = params[:reminder_msg]
		@reminder_time = params[:reminder_time]
		@tasks = Task.all(:order => :priority.desc)
		$task_count = Task.count;
		$pending = Task.count(:done => false)
		$completed = $task_count.to_i - $pending.to_i
		@page_title = "Tasks"
		@content_title = "All tasks on my list"
		@title = ""
		redirect '/new' if @tasks.empty? || @tasks.nil?
		erb :index
	end

	get '/track_data' do
	tasks = "";
		@tasks = Task.all(:order => :created.desc, :conditions => {:created_by => session[:username]})
		@tasks.each do |task|
		     tasks += "<div class='sidebar_task'>"\
				"<h4><i class='fa fa-calendar fa-6'></i>#{task.created.strftime("%e %B %Y")}</h4>"\
		        "<p>#{task.content}</p>"\
			      "<a href='#'><i>View task</i></a>"\
		      "</div><!--close sidebar_task--> ";
		end
		tasks 
	end

	post '/new' do
		@page_title = "New_task"
		@content_title = "Add a task"
		params[:priority] ||= 3
		puts "new: value of priority: #{params[:priority]}"
		Task.create(:content => params[:content], :priority => params[:priority],\
		 				:due_date => params[:due_date], :due_time => params[:due_time],\
		 				:reminder => params[:reminder], :created_by => session[:username], :created => Time.now)
		redirect "/task?success_message=#{params[:success_message]}"
	end

	post '/done' do
		puts "Got to done"
		task = Task.first(:id => params[:id])
		task.done = !task.done
		task.save
		content_type 'application/json'
		value = task.done ? 'done' : 'not done'
		puts "the message should be #{task.content}"
		{:id => params[:id], :status => value, :content => task.content }.to_json
	end


	post '/priority' do
		task = Task.first(:id => params[:id])
		task.priority = params[:priority_value]
		puts "priority sent: #{task.priority}"
		content_type 'application/json'
		value = task.save;
		puts "value of priority: #{params[:priority_value]}"
		params[:priority_value]
	end


	get '/delete/:id' do
		@task = Task.first(:id => params[:id])
		erb :delete_task
	end

	post '/delete/:id' do
		if params.has_key?("ok")
			task = Task.first(:id => params[:id])
			task.destroy
			puts "did it get here?"
			redirect to '/task'
		else
			redirect to '/task'
		end
	end

end