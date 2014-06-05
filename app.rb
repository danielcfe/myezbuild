require 'rubygems'
require 'sinatra/base'
require 'haml'
require 'sass'
require 'mongoid'

Mongoid.load!("config/mongoid.yml")

class App < Sinatra::Base
    
  set :public, File.join(File.dirname(__FILE__), 'public')
  set :views, File.join(File.dirname(__FILE__), 'views')

  helpers do
    def partial(page, options={})
      haml page, options.merge!(:layout => false)
    end
  end

  get('/'){ haml :index}

end
