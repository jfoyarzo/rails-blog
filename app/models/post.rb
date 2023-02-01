class Post < ApplicationRecord
  has_many :comments, :likes
  belongs_to :user, foreign_key: 'author_id'
end
