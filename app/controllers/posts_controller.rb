class PostsController < ApplicationController
  authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
    @user = User.find(params[:user_id])
    @comment = Comment.new
    @like = Like.new
    respond_to do |format|
      format.html { render :show, locals: { comment: @comment, like: @like } }
    end
  end

  def new
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: } }
    end
  end

  def create
    post = Post.new(params.require(:post).permit(:title, :text))
    post.user = current_user
    respond_to do |format|
      format.html do
        if post.save
          flash[:notice] = 'Post saved successfully'
          redirect_to users_path
        else
          flash.now[:error] = 'Error: Post could not be saved'
          render :new, locals: { post: }, status: 422
        end
      end
    end
  end

  def destroy
    post = Post.find(params[:id])
    respond_to do |f|
      f.html do
        if post.destroy
          flash[:success] = 'Post deleted successfully'
          redirect_to user_posts_path(params[:user_id])
        else
          flash.now[:error] = 'Error: Post could not be deleted'
          render :show, status: :unprocessable_entity, locals: { post: }
        end
      end
    end
  end
end
