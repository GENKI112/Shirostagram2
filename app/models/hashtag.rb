class Hashtag < ApplicationRecord
  has_many :post_taggings, dependent: :destroy
  has_many :posts, through: :post_taggings
  validates :label, presence: true, length: { maximum: 50 }
end
