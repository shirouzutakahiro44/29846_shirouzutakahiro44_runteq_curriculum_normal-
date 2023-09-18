class Board < ApplicationRecord
    validates :title, presence: true
    validates :title, length: { maximum: 255 }
    validates :description, presence: true
    validates :description, length: {maximum: 65_535}
    mount_uploader :image, ImageUploader

    belongs_to :user
    has_many :comments, dependent: :destroy
    
end
