class PostsController < Omega::Controller
  deny(:update).if do
    @post = Post.find(params[:id])
    @post.owner != current_user
  end

  get :index => "/posts" do
    @posts = Post.all

    respond_with(@posts)
  end

  get :show => "/posts/:id" do
    @post = Post.find(params[:id])

    respond_with(@post)
  end

  put :update => "/posts/:id" do
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])

    # if @post is invalid it responds 403 and the error messages
    # if @post is valid it only returns the fields listed by Post.publishable_fields
    respond_with(@post)
  end

  post :create => "/posts" do
    @post = Post.create(params[:post])
    respond_with(@post)
  end

  delete :destroy => "/posts/:id" do
    @post = Post.find(params[:id])

    ok
  end
end

