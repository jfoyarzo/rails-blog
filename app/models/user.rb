class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, dependent: :destroy, foreign_key: 'author_id', inverse_of: :user
  has_many :comments, dependent: :destroy, foreign_key: 'author_id', inverse_of: :user
  has_many :likes, dependent: :destroy, foreign_key: 'author_id', inverse_of: :user
  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  scope :recent_posts, ->(user_id) { Post.where(author_id: user_id).last(3) }
  before_validation :initialize_defaults

  private

  def initialize_defaults
    self.posts_counter ||= 0
    self.role ||= 'default'
  end
end
