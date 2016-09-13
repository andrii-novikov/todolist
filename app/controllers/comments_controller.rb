class CommentsController < ApplicationController
  authorize_resource
  before_action :set_comment, except: :create

  def create
    @comment = Comment.create(comments_params)
  end

  def destroy
    @comment.try(:destroy)
  end

  def update
    @comment.update(comments_params.except(:id, :task_id))
  end

  private
  def set_comment
    @comment = Comment.find_by(comments_params.except(:text, :attachment))
  end

  def comments_params
    params.permit(:id, :task_id, :text, :attachment)
  end
end
