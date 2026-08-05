class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :destroy ]

  def show
    render json: Post.find(params[:id])
  end

  def create
    post = current_user.posts.build(post_params)

    if post.save
      render json: post, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])

    if post.destroy
      head :no_content
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.expect(post: [ :title, :body ])
  end
end
