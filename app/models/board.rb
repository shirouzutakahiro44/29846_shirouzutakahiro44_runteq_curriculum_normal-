class Board < ApplicationRecord
    validates :title, presence: true
    validates :title, length: { maximum: 255 }
    validates :description, presence: true
    validates :description, length: {maximum: 65_535}
    mount_uploader :image, ImageUploader

    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :bookmarks, dependent: :destroy

    def bookmarked_by?(user)
        bookmarks.where(user_id: user).exists?
    end
    
end
