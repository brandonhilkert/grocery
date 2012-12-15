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

    post '/lists' do
      list = List.new
      redirect "/lists/#{list}/items"
    end

    get '/lists/:id/items' do
      @list = Project::List.new(params[:id])
      @items = @list.items
      haml :items
    end

    post '/lists/:id/items' do
      list = Project::List.new(params[:id])
      unless params[:name].empty?
        list.add_item(params[:name])
      end

      redirect "/lists/#{list}/items"
    end

    delete '/lists/:id/items' do
      list = Project::List.new(params[:id])
      list.remove_item(params[:name])
      redirect "lists/#{list}/items"
    end

  end
end