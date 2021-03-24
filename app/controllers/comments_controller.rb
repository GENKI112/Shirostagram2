class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i(create)

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
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post
    if @comment.destroy
      respond_to :js
    else
      flash[:alert] = "コメントの削除に失敗しました"
    end
  end
  private
  def comment_params
    params.required(:comment).permit(:comment).merge(post_id: @post,user_id: current_user.id)
  end
  def set_post
    @post = params[:post_id]
  end
end
