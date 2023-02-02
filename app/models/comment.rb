class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, foreign_key: 'author_id'

  def self.update_comments_counter(post_id)
    post = Post.find(post_id)
    counter = post.comments.count
    post.update(comments_counter: counter)
  end
end
