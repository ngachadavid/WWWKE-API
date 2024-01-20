class Author < ApplicationRecord
    has_many :articles
    validates :name, presence: true
    validates :bio, length: { maximum: 300 }
    
    has_one_attached :profile_image
end
