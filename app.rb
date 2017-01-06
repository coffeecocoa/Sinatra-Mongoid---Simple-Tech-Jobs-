require "sinatra"
require "sinatra/reloader"
# require "sinatra-authentication"
require "mongoid"
require "haml"

configure do
	#db setup
	Mongoid.load!("mongoid.config")
	# enable :sessions
	use Rack::Session::Cookie, secret: 'thisisreallyreallysecret'
	set :server , :puma
end

class Job
	include Mongoid::Document
	include Mongoid::Timestamps

	field :title , type: String
	field :company, type: String
	field :website , type: String
	field :description, type: String
	field :contact_email, type: String
end

#index page
get "/" do
	@title = "Tech Jobs"
	haml :home
end

#about page
get "/about" do
	@title = "About"
	haml :about
end

#list of jobs page
get "/list" do
	@title = "Job List"
	@jobs = Job.all().order_by(created_at: :desc)
	haml :list
end

#create a new job page
get "/new" do
	@title = "Post a New Job"
	haml :new
end

#post handle create a new job
post "/create" do
	@job = Job.new(params[:job])
	if @job.save
		redirect "/show/#{@job._id}"
	else
		redirect "/list"
	end
end

#view a job by id
get "/show/:id" do 
	@title = "Job Details"
	@job = Job.find(params[:id])

	if @job
		haml :show
	else
		redirect "/list"
	end
end

#update/edit jobs page
get "/edit/:id" do 
	@title = "Update and Edit a existing Job"
	@job = Job.find(params[:id])
	haml :edit
end

#update handle for job post
put "/show/:id" do |id|
	@job = Job.find(params[:id]) #Job.where(id: params[:id]).first
	@job.update_attributes(params[:job])
	# haml :show
	if @job
		redirect "/show/#{@job._id}"
	else
		redirect "/list"
	end
end