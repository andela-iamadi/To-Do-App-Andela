require 'dm-core'
require 'dm-migrations'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/todo_list.db")

class Task
	include DataMapper::Resource
	property :id, Serial
	property :content, Text, :required => true
	property :done, Boolean, :required => true, :default => false
	property :priority, Integer, :default => 3
	property :due_date, DateTime, :default => Time.now
	property :due_time, DateTime, :default => Time.now
	property :show_reminder, Boolean, :default => true
	property :reminder, DateTime, :default => Time.now
	property :created_by, String
	property :created, DateTime
end

class User
	include DataMapper::Resource
	property :id, Serial
	property :username, String
	property :password, String
	property :firstname, String
	property :lastname, String
	property :email, String
	property :avatar, String
	property :watch_word, Text
	property :created, DateTime
end

class Notification
	include DataMapper::Resource
	property :id, Serial
	property :message, String
	property :username, String
	property :viewed, Boolean, :default => false
	property :created_by, String
	property :created, DateTime
end

class Project
	include DataMapper::Resource
	property :id, Serial
	property :title, String
	property :description, Text
	property :created_by, String
	property :done, Boolean, :required => true, :default => false
	property :created, DateTime
end

class Team
	include DataMapper::Resource
	property :id, Serial
	property :description, Text
	property :created_by, String
	property :created, DateTime
end

class TeamMembers
	include DataMapper::Resource
	property :id, Serial
	property :username, String
	property :user_role, String
	property :created, DateTime
end

class Assignment
	include DataMapper::Resource
	property :id, Serial
	property :item_id, Integer
	property :description, Text
	property :task_scope, String
	property :task, Integer
	property :handler_scope, String
	property :handlers, String
	property :created_by, String
	property :done, Boolean, :required => true, :default => false
	property :created, DateTime
end

DataMapper.finalize.auto_upgrade!