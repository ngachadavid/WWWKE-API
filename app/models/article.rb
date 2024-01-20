class Article < ApplicationRecord
  belongs_to :user
  belongs_to :author
  has_many :category_articles
  has_many :categories, through: :category_articles
  has_one_attached :image
end
