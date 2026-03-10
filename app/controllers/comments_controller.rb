class CommentsController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: Comment.with_reactions.find(params[:id])
  end
  def create
    micropost = Micropost.find(params[:micropost_id])
    comment = micropost.comments.build(comment_params.merge(user: current_user))
    if comment.save
      render json: comment, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    comment = @post.comments.find(params[:id])
    return head(:forbidden) unless comment.deletable_by?(current_user)

    comment.destroy
    head :no_content
  end

  private

  def comment_params
    params.expect(comment: :body)
  end
end
