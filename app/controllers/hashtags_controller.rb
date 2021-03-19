class HashtagsController < ApplicationController
  before_action :authenticate_user!
  def index
    @label = params[:label_name]
    post_in_label = Hashtag.find_by(label: params[:label_name])
    @posts = post_in_label.posts.order('created_at DESC')
  end
end
