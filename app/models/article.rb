class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 5, maximum: 100 }
#  belongs_to :user
#  has_many :article_categories
#  has_many :categories, through: :article_categories
end
