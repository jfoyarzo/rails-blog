class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :user, foreign_key: 'author_id'
  scope :recent_comments, ->(post_id) { Comment.where(post_id:).last(5) }

  def self.update_post_counter(user_id)
    user = User.find(user_id)
    counter = user.posts.count
    user.update(posts_counter: counter)
  end
end
