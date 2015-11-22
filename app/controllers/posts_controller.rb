class PostsController < ApplicationController

  def index
    @posts = Post.order('created_at DESC').all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order('created_at')
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = "Your post was successful!"
      redirect_to root_path
    else
      flash.now[:alert] = "Don't leave your post blank. The world needs to know how you feel!"
      render 'new'
    end
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end
end
