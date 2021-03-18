class Hashtag < ApplicationRecord
  has_many :post_taggings, dependent: :destroy
  has_many :posts, through: :post_taggings
  validates :label, presence: true, length: { maximum: 50 }
  Hashtag_conditions = %r{[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+}
  Lead_pound = %r{[#＃]}
  def self.hashtag_source_of_judgment
    Hashtag_conditions
  end
  def self.hashtag_scan(caption)
    caption.scan(hashtag_source_of_judgment)
  end
  def self.pound_delete_at_hashtag(word)
    word.gsub(Lead_pound, '')
  end
end
