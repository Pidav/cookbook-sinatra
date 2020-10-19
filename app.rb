require_relative 'cookbook'
require_relative 'recipe'
require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end


get '/' do
  @cookbook = Cookbook.new('recipes.csv').all
  erb :index
end

get '/new' do
  erb :new
end

post '/recipes' do
  @new_recipe = Recipe.new(
    { name: params["name"],
      rating: params["rating"],
      prep_time: params["time"],
      description: params["description"],
      done: false }
    )
  @updated = Cookbook.new('recipes.csv')
  @updated.add_recipe(@new_recipe)
  @cookbook = Cookbook.new('recipes.csv').all
  erb :index
end


get '/about' do
  erb :about
end

