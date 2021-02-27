class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :post_taggings, dependent: :destroy
  has_many :hashtags, through: :post_taggings

  accepts_nested_attributes_for :photos

  def liked_by(user)
    Like.find_by(user_id: user.id, post_id: id)
  end

  after_create do
    # 作成した投稿を探す
    post = Post.find_by(id: self.id)
    hashtags = post.caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      # ハッシュタグは先頭の'#'を外した上で保存するようにする
      tag = Hashtag.find_or_create_by(label: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end

  before_update do 
    post = Post.find_by(id: self.id)
    post.hashtags.clear
    hashtags = post.caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(label: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end
  
end
