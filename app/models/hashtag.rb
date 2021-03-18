class Hashtag < ApplicationRecord
  has_many :post_taggings, dependent: :destroy
  has_many :posts, through: :post_taggings
  validates :label, presence: true, length: { maximum: 50 }

  def self.hashtag_source_of_judgment
    /[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/
  end
  def self.hashtag_scan(caption)
    caption.scan(hashtag_source_of_judgment)
  end
  def self.pound_delete_at_hashtag(word)
    word.gsub(/[#＃]/, '')
  end
end
