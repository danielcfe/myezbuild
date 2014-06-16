require 'rubygems'
require 'sinatra/base'
require 'haml'
require 'sass'
require 'mongoid'
require 'pony'
require 'mail'

Mongoid.load!("config/mongoid.yml")

this_dir = Pathname.new(File.dirname(__FILE__))
['models/**/*'].each do |dir_path|
  Dir[dir_path].each { |file_name| require this_dir + "./#{file_name}"}
end

class App < Sinatra::Base
    
  set :public, File.join(File.dirname(__FILE__), 'public')
  set :views, File.join(File.dirname(__FILE__), 'views')

  helpers do
    def partial(page, options={})
      haml page, options.merge!(:layout => false)
    end
  end

  get('/')do
    @lead = Lead.new
    @options = ConfigLead.setup
    haml :index
  end

  post "/lead" do
    lead = Lead.new(params)
    if lead.valid?
      Mailer.send_lead(params[:name], params[:email], params[:comment], params[:type])
    else
      status('412')
      lead.errors.to_json
    end
  end

  get('/') do
    @lead = Lead.new
    @options = ConfigLead.setup
    haml :"frontend/index", :layout => :"frontend/layout"
  end

end
