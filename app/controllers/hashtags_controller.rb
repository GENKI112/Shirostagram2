class HashtagsController < ApplicationController
  before_action :authenticate_user!
  def index
    @label = params[:label_name]
    post_in_label = Hashtag.find_by(label: @label)
    if post_in_label.nil?
      redirect_to root_path, alert: "#" + "#{@label}のタグがついた投稿は存在しません"
    else
      @posts = post_in_label.posts.includes(:photos, :user).order('created_at DESC')
    end
  end
end
