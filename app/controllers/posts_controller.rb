class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
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
    user = current_user
    post = Post.new(params.require(:post).permit(:title, :text))
    post.author_id = user.id
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
end
