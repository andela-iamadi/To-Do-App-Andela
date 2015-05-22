

class AssignmentController < Server

	get "/" do
		if session[:username] == "" || session[:username] == nil
			redirect '/user/login'
		end
		@projects = ""
		@projects = Project.all(:order => :created.desc, :conditions => { :created_by => session[:username]})
		@project_count = Project.count;
		@pending = Project.count(:done => false)
		@completed = @project_count.to_i - @pending.to_i
		puts "In ptrojects route"
		@page_title = "Projects"
		@content_title = "Projects I manage"
		redirect '/assignment/new' if @projects.empty? || @projects.nil?
		erb :index
	end

	get '/new' do
		@title = "Assign someone to a task"
		erb :new_team
	end

	get '/edit' do
		@title = "Edit Assignment"
		erb :edit_team
	end

	get '/track_data' do
		assignments = "";
		@assignments = Assignment.all(:order => :created.desc, :conditions => { :username => session[:username]})
		@assignments.each do |item|
		     assignments += "<div class='sidebar_item'>"\
				"<h4><i class='fa fa-calendar fa-6'></i>#{item.created.strftime("%e %B %Y")}</h4>"\
		        "<p>#{item.description}</p>"\
			      "<a href='#'><i>View assignment</i></a>"\
		      "</div><!--close sidebar_item--> ";
		end
		projects 
	end

	post '/new' do
		Assignment.create(:item_id => params[:item_id], :user_role => params[:user_role],\
							:task_scope => params[:task_scope], :task => params[:task],\
							:handler_scope => params[:task], :handler_scope => params[:handler],\
							:created_by => params[:username], :created => Time.now)
		redirect '/team'
	end

	post '/done' do
		assignment = Assignment.first(:id => params[:id])
		assignment.done = !item.done
		assignment.save
		content_type 'application/json'
		value = assignment.done ? 'done' : 'not done'
		{:id => params[:id], :status => value }.to_json
	end

	get '/delete/:id' do
		@assignment = Assignment.first(:id => params[:id])
		erb :delete
	end

	post '/delete/:id' do
		if params.has_key?("ok")
			project = Assignment.first(:id => params[:id])
			project.destroy
			redirect '/Assignment'
		else
			redirect '/Assignment'
		end
	end

end