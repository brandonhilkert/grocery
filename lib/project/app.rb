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
      def redis
        Project.redis
      end

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
      @items = redis.smembers("list:#{@list}:items")
      haml :items
    end

    post '/lists/:list_id/items' do
      unless params[:name].empty?
        redis.sadd("list:#{params[:list_id]}:items", params[:name])
      end

      redirect "/lists/#{params[:list_id]}/items"
    end

    delete '/lists/:list_id/items' do
      redis.srem("list:#{params[:list_id]}:items", params[:name])
      redirect "lists/#{params[:list_id]}/items"
    end

  end
end