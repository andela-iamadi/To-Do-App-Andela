

class TeamController < Server
	get '/new' do
		@title = "Add todo task"
		erb :new_team
	end

	get '/edit' do
		@title = "Edit Project"
		erb :edit_team
	end

	get '/track_data' do
		teams = "";
		@teams = Project.all(:order => :created.desc, :conditions => { :username => session[:username]})
		@teams.each do |item|
		     projects += "<div class='sidebar_item'>"\
				"<h4><i class='fa fa-calendar fa-6'></i>#{item.created.strftime("%e %B %Y")}</h4>"\
		        "<p>#{item.content}</p>"\
			      "<a href='#'><i>View task</i></a>"\
		      "</div><!--close sidebar_item--> ";
		end
		projects 
	end

	post '/new' do
		Team.create(:description => params[:description], :created_by => params[:created_by], :created => Time.now)
		redirect '/teams'
	end

	post '/done' do
		project = Team.first(:id => params[:id])
		project.done = !item.done
		project.save
		content_type 'application/json'
		value = project.done ? 'done' : 'not done'
		{:id => params[:id], :status => value }.to_json
	end

	get '/delete/:id' do
		@project = Team.first(:id => params[:id])
		erb :delete
	end

	post '/delete/:id' do
		if params.has_key?("ok")
			project = Team.first(:id => params[:id])
			project.destroy
			redirect '/Projects'
		else
			redirect '/Projects'
		end
	end

end


class TeamMemberController < TeamController
	get '/new' do
		@title = "Add todo task"
		erb :new_team
	end

	get '/edit' do
		@title = "Edit Team"
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
		Team.create(:username => params[:username], :user_role => params[:user_role], :created => Time.now)
		redirect '/team'
	end

	post '/done' do
		project = Team.first(:id => params[:id])
		project.done = !item.done
		project.save
		content_type 'application/json'
		value = project.done ? 'done' : 'not done'
		{:id => params[:id], :status => value }.to_json
	end

	get '/delete/:id' do
		@project = Team.first(:id => params[:id])
		erb :delete
	end

	post '/delete/:id' do
		if params.has_key?("ok")
			project = Team.first(:id => params[:id])
			project.destroy
			redirect '/Project'
		else
			redirect '/Project'
		end
	end

end