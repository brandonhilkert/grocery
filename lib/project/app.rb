module Project
  class App < Sinatra::Base
    set :root, Project.root
    enable :sessions

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
      haml :index
    end

    post '/lists' do
      list = List.new
      redirect "/lists/#{list}/items"
    end

    get '/lists/:list_id/items' do
      @list = params[:list_id]
      @items = ["asdf"]
      haml :items
    end

    post '/lists/:list_id/items' do
      # Add to list
      list = params[:list_id]
      redirect "/lists/#{list}/items"
    end

  end
end