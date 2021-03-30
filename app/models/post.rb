class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_taggings, dependent: :destroy
  has_many :hashtags, through: :post_taggings

  accepts_nested_attributes_for :photos
  after_create :generate_hashtag

  scope :recent, -> { order(created_at: :desc) }

  def self.only_current_user(post, current_user)
    post.user_id == current_user.id
  end

  def like_to_post_by(user)
    post_likes = self.likes
    post_likes.find_by(user_id: user.id)
  end

  private
  def generate_hashtag
    post_labels = Hashtag.hashtag_scan(caption)
    post_labels.uniq.each do |word|
      self.hashtags << Hashtag.find_or_create_by(label: Hashtag.pound_delete_at_hashtag(word))
    end
  end
end
