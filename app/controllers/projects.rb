

class ProjectController < Server

	get "/" do
		if session[:username] == "" || session[:username] == nil
			redirect '/user/login'
		end
		@projects = ""
		@projects = Project.all(:order => :created.desc)
		@project_count = Project.count;
		@pending = Project.count(:done => false)
		@completed = @project_count.to_i - @pending.to_i
		puts "In projects route"
		@page_title = "Projects"
		@content_title = "Projects I manage"
		if @projects.empty? || @projects.nil?
			@content_title = "Add your first project"
			puts "New projects en route"
			redirect '/project/new' 
		end
		erb :projects
	end

	get '/new' do
		@title = "Add todo task"
		erb :new_project
	end

	get '/edit' do
		@title = "Edit Project"
		erb :edit_project
	end

	get '/track_data' do
		projects = "";
		@projects = Project.all(:order => :created.desc, :conditions => { :created_by => $username})
		@items.each do |item|
		     projects += "<div class='sidebar_item'>"\
				"<h4><i class='fa fa-calendar fa-6'></i>#{item.created.strftime("%e %B %Y")}</h4>"\
		        "<p>#{item.content}</p>"\
			      "<a href='#'><i>View task</i></a>"\
		      "</div><!--close sidebar_item--> ";
		end
		projects 
	end

	post '/new' do
		Project.create(:title => params[:title], :description => params[:description],\
		 						:created_by => session[:userame], :created => Time.now)
		redirect '/'
	end



	post '/done' do
		project = Project.first(:id => params[:id])
		project.done = !item.done
		project.save
		content_type 'application/json'
		value = project.done ? 'done' : 'not done'
		{:id => params[:id], :status => value }.to_json
	end

	get '/delete/:id' do
		@project = Project.first(:id => params[:id])
		erb :delete
	end

	post '/delete/:id' do
		if params.has_key?("ok")
			project = Project.first(:id => params[:id])
			project.destroy
			redirect '/Project'
		else
			redirect '/Project'
		end
	end

end