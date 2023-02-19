class CommentsController < ApplicationController
  def create
    user = current_user
    post = Post.find(params[:comment][:post_id])
    comment = Comment.new(params.require(:comment).permit(:text, :post_id))
    comment.author_id = user.id
    respond_to do |format|
      format.html do
        if comment.save
          Comment.update_comments_counter(comment.post_id)
          flash[:notice] = 'Comment saved successfully'
          redirect_to user_post_path(post.author_id, comment.post_id)
        else
          flash.now[:error] = 'Error: Comment could not be saved'
          redirect_to user_post_path(post.author_id, params[:comment][:post_id])
        end
      end
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    respond_to do |f|
      f.html do
        if comment.destroy
          comment.update_comments_counter(params[:post_id])
          flash[:success] = 'Comment deleted successfully'
          redirect_to user_post_path(params[:user_id], params[:post_id])
        else
          flash.now[:error] = 'Error: Comment could not be deleted'
          render :show, status: :unprocessable_entity, locals: { comment: }
        end
      end
    end
  end
end
