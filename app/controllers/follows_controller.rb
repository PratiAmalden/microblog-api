class FollowsController < ApplicationController
  before_action :authenticate_user!
  def create
    user = User.find(follow_params[:followed_id])
    follow = current_user.follow(user)

    if follow.persisted?
      render json: follow.slice(:id, :follower_id, :followed_id), status: :created
    else
      render json: { errors: follow.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.unfollow(params[:followed_id])
    head :no_content
  end

  private

  def follow_params
    params.expect(follow: :followed_id)
  end
end
