get '/' do
  # render home page
  @users = User.all
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page
  erb :sign_in
end

post '/sessions' do
  user = User.find_by_email params[:email]
  if user != nil
    session[:user_id] = user.id
  else
    erb :error
  end
  redirect to('/')
end

delete '/sessions/:id' do
  if session.has_key?(:user_id)
    session.delete(:user_id)
  end
  redirect to('/')
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  erb :sign_up
end

post '/users' do
  user = User.new(params[:user])
  user.password = params[:password]
  user.save!
  redirect to('/')
end