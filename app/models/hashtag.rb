class Hashtag < ApplicationRecord
  has_many :post_taggings, dependent: :destroy
  has_many :posts, through: :post_taggings
  validates :label, presence: true, length: { maximum: 50 }

  LEAD_POUND = "[#＃]"
  HASHTAG_CONDITIONS = %r{#{LEAD_POUND}[\w\p{Han}ぁ-ヶｦ-ﾟー]+}

  def self.hashtag_scan(caption)
    caption.scan(HASHTAG_CONDITIONS)
  end

  def self.pound_delete_at_hashtag(word)
    word.gsub(/#{LEAD_POUND}/, '')
  end
end
