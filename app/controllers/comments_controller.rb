class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    micropost = Micropost.find(params[:micropost_id])
    comment = micropost.comments.build(comment_params.merge(user: current_user))
    if comment.save
      render json: comment, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.expect(comment: :body)
  end
end
