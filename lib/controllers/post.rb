get '/posts' do
    json Post.all(slice).to_a
end

get '/posts/search' do
    unless params[:q] 
        error 400, "Missing search parameter"
    end
    json Post.all(slice.merge(:title.like => "%#{params[:q]}%")).to_a    
end

put '/posts' do
    protected!
    post = Post.new(:title => params[:title],
        :text => params[:text],
        :user => @user)
    if post.save
        json post
    else
        error 400, post.errors
    end
end

get '/posts/:id' do
    post = Post.get(params[:id])
    unless post
        halt 404, "Post not found"
    end
    json post
end

