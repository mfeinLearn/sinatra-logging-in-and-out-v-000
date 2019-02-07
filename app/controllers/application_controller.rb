require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    #binding.pry
    if @user
      session[:user_id] = @user.id
      redirect '/account'
    else
      erb :error
    end
  end

  get '/account' do
     if !session[:user_id]
      erb :error
    else
      # Helpers.current_user(session)
      @user = User.find_by(id: session[:user_id])

       erb :account
     end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


end
