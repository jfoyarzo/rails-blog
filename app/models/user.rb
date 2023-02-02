class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes
  scope :recent_posts, lambda { |user_id|
                         Post.where(author_id: user_id).last(3)
                       }
end
