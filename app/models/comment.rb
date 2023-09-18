class Comment < ApplicationRecord
  validates :body, presence: true
  validates :body, length: {maximum: 65_535}
  belongs_to :user
  belongs_to :board
end
