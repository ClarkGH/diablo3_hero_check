get '/' do
  # render home page
  # @users = User.all
  erb :index
end

#----------- API REQUESTS -------

post '/battletag_account/new' do
  user = User.new(user_params)
  if user.save
    request = HTTPI::Request.new
    request.url = "https://us.battle.net/api/d3/profile/#{user.battletag}-#{user.battletag_code}/"
    user_response = HTTPI.get(request)
    parsed_response = user_response.body
    parsed_json_response = JSON.parse(parsed_response)
    create_heroes(user, parsed_json_response)
    @heroes = user.heros
    erb :_heroes, layout: false
  else
    @errors = user.errors
    status 400
    erb :_errors, layout: false
  end
end

def create_heroes(user, data)
  data['heroes'].each do |hero_data|
    user.heros << Hero.new(
      name: hero_data['name'],
      level: hero_data['level'].to_i,
      blizz_id: hero_data['id'].to_i,
      gender: hero_data['gender'].to_i,
      hero_class: hero_data['class'])
  end
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

#------------ Private Methods -----

private
def user_params
  {battletag: params[:battletag], battletag_code: params[:battletag_code].to_i}
end