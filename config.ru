require 'bundler'
Bundler.require

require File.expand_path('../config/environment',  __FILE__)

map ('/user') { run UserController }
map ('/task') { run TaskController }
map ('/team') { run TeamController }
map ('/team/member') { run TeamController }
map ('/project') { run ProjectController }
map ('/projects') { run ProjectController }
map ('/assignment') {run Assignment }
map ('/notification') { run NotificationController }

map ('/') { run Server }