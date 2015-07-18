class CommentsController < ApplicationController

  def new
    if logged_in?
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build
    else
      flash[:notice] = "You need to sign up first."
      redirect_to signup_path
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "You made a comment!"
      redirect_to post_path id: @comment.post_id
    else
      flash.now[:alert] = "Don't leave your comment blank! The world needs to know how you feel!"
      render 'new'
    end
  end


  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
