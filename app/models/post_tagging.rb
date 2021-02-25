class PostTagging < ApplicationRecord
  belongs_to :post
  belongs_to :hashtag
end
