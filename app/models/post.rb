class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :user, foreign_key: 'author_id'
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  scope :recent_comments, ->(post_id) { Comment.where(post_id:).last(5) }
  before_validation :initialize_counters

  def self.update_posts_counter(user_id)
    user = User.find(user_id)
    counter = user.posts.count
    user.update(posts_counter: counter)
  end

  private

  def initialize_counters
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end
end
