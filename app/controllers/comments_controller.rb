class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :searching_post_id, only: %i(create destroy)

  def create
    @comment = Comment.new(comment_params)
    @post = @comment.post
    if @comment.save
      respond_to :js
    else
      flash[:alert] = "コメントの投稿に失敗しました"
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], user_id: current_user.id)
    @post = @comment.post
    if @comment.destroy
      respond_to :js
    else
      flash[:alert] = "コメントの削除に失敗しました"
    end
  end

  private
  def comment_params
    params.required(:comment).permit(:comment).merge(post_id: @post.id,user_id: current_user.id)
  end

  def searching_post_id
    @post = Post.find_by(id: params[:post_id])
  end
end
