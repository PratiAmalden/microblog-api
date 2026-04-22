class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :destroy ]
  before_action :set_post

  def index
    render json: @post.comments
  end

  def show
    render json: @post.comments.find(params[:id])
  end

  def create
    comment = @post.comments.build(comment_params.merge(user: current_user))
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

  def set_post
    @post = Micropost.find(params[:micropost_id])
  end
end
