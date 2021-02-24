class HashtagPostImage < ApplicationRecord
  belongs_to :posts
  belongs_to :hashtag
end
