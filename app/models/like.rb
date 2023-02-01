class Like < ApplicationRecord
  belongs_to :comment
  belongs_to :user, foreign_key: 'author_id'
end
