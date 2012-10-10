get '/users' do
    json User.all(slice).to_a
end

get '/users/search' do
    unless params[:q] 
        error 400, "Missing search parameter"
    end
    json User.all(slice.merge(:name.like => "%#{params[:q]}%")).to_a    
end

#Create a User
put '/users' do
    user = User.new(:name => params[:name], :email => params[:email], :password => params[:password])
    if user.save
        json user
    else
        error 400, user.errors
    end
end

get '/users/:id' do
    user = User.get(params[:id])
    unless user
        halt 404, "User not found"
    end
    json user
end

#Attach a resume to an user
post '/users/:id/resume' do
    user = User.get(params[:id])
    unless user
        halt 404, "User not found"
    end
    user.resume = to_paperclip(params[:resume])
    user.save
    json user
end

def to_paperclip(document)
  paperclip = {}
  paperclip['tempfile'] = document[:tempfile]
  paperclip['filename'] = document[:filename]
  paperclip['content_type'] = document[:type]
  paperclip['size'] = document[:tempfile].size
  paperclip  
end
