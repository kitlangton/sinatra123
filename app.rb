require 'sinatra'
require 'thin'
require 'sinatra/reloader' if development?
require 'rack-flash'
require_relative 'lib/tower_of_hanoi'

use Rack::Flash
enable :sessions

helpers do
  def load_tower
    unless session[:towers]
      TowerOfHanoi.new
    else
      TowerOfHanoi.new(session[:towers])
    end
  end

  def save_tower(tower_of_hanoi)
    session[:towers] = tower_of_hanoi.towers
  end
end

get '/' do
  tower_of_hanoi = load_tower
  if tower_of_hanoi.win?
    session[:towers] = nil
  end
  erb :game, locals: { tower_of_hanoi: tower_of_hanoi }
end

post '/move' do
  tower_of_hanoi = load_tower
  from, to = params[:from].to_i, params[:to].to_i
  if tower_of_hanoi.valid_move?(from,to)
    tower_of_hanoi.move(from, to)
    save_tower(tower_of_hanoi)
  else
    flash[:notice] = "Invalid move"
  end
  redirect '/'
end
