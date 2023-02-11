class LikesController < ApplicationController
  def create
    user = current_user
    post = Post.find(params[:new_like][:post_id])
    like = Like.new(params.require(:new_like).permit(:post_id))
    like.author_id = user.id
    respond_to do |format|
      format.html do
        if like.save
          Like.update_likes_counter(like.post_id)
          flash[:notice] = 'Liked!'
        else
          flash.now[:error] = 'Error: Like could not be saved'
        end
        redirect_to user_post_path(post.author_id, post.id)
      end
    end
  end
end
