# frozen_string_literal: true
class CommentsController < ApplicationController
  load_and_authorize_resource :task
  load_and_authorize_resource :comment, through: :task

  def create
    @comment.save
  end

  def destroy
    @comment.destroy
  end

  def update
    @comment.update(comment_params.except(:id, :task_id))
  end

  private

  def comment_params
    params.permit(:task_id, :text, :attachment)
  end
end
