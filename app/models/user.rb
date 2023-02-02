class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id', inverse_of: :user
  has_many :comments, foreign_key: 'author_id', inverse_of: :user
  has_many :likes, foreign_key: 'author_id', inverse_of: :user
  scope :recent_posts, ->(user_id) { Post.where(author_id: user_id).last(3) }
end
