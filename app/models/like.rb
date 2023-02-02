class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user, foreign_key: 'author_id'

  def self.update_likes_counter(post_id)
    post = Post.find(post_id)
    counter = post.likes.count
    post.update(likes_counter: counter)
  end
end
