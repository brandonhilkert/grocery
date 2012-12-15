require "pry"

module Project
  class App < Sinatra::Base
    set :root, Project.root
    enable  :method_override

    set :sprockets, Sprockets::Environment.new(root) { |env|
      env.append_path(root.join('assets', 'stylesheets'))
      env.append_path(root.join('assets', 'javascripts'))
    }

    configure :development do
      register Sinatra::Reloader
    end

    helpers do
      def asset_path(source)
        "/assets/" + settings.sprockets.find_asset(source).digest_path
      end
    end

    get '/' do
      erb :index
    end

    get '/lists/:id/items' do
      content_type :json
      @list = Project::List.new(params[:id])
      MultiJson.dump @list.items.map{ |item| { name: item} }
    end

    post '/lists/:id/items' do
      list = Project::List.new(params[:id])
      body = MultiJson.load request.body.read
      item = body.fetch("name", nil)
      list.add_item(item) unless item.nil?
      :ok
    end

    delete '/lists/:id/items' do
      list = Project::List.new(params[:id])
      body = MultiJson.load request.body.read
      item = body.fetch("name", nil)
      list.remove_item(item)
      :ok
    end

  end
end