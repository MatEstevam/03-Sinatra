require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"

require_relative "../config/application"

set :root, File.expand_path("..", __dir__)
set :views, proc { File.join(root, "app/views") }
set :bind, '0.0.0.0'

after do
  ActiveRecord::Base.connection.close
end

get "/" do
  # TODO
  # 1. fetch posts from database.
  # 2. Store these posts in an instance variable
  # 3. Use it in the `app/views/posts.erb` view

  @posts = Post.order(votes: :desc)

  erb :posts # Do not remove this line
end

# TODO: add more routes to your app!

post "/posts" do
  @post = Post.new(title: params[:title], content: params[:content])
  if @post.save
    redirect "/"
  else
    # Se houver erros ao salvar o post, você pode lidar com isso aqui
    erb :error # Adicione uma visualização de erro, se necessário
  end
end
