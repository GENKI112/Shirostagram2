class PostTagging < ApplicationRecord
  belongs_to :post
  belongs_to :hashtag
  validates :post_id, presence: true
  validates :hashtag_id, presence: true
  validates :post_id, uniqueness: { scope: :hashtag_id }
end
