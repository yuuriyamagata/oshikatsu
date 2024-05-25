class PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def index
    @post = Post.new
    @posts = Post.all
    @user = current_user
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "You have posted successfully."
      redirect_to post_path(@post)
    else
      @user = current_user
      @posts = Post.all
      render :index
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @new_post = Post.new
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "You have destroyed post successfully."
    redirect_to posts_path
  end
  
  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
       flash[:notice] = "You have updated post successfully."
       redirect_to post_path(@post.id)
    else
       render :edit
    end
  end

  private

   def post_params
     params.require(:post).permit(:title, :body)
   end
  
   def ensure_correct_user
       post = Post.find(params[:id])
       unless post.user_id == current_user.id
        redirect_to posts_path
       end
   end
end
