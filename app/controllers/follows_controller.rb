class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(follow_params[:followed_id])
    follow = current_user.followed_users.build(followed: user)

    if follow.save
      render json: follow.slice(:id, :follower_id, :followed_id), status: :created
    else
      render json: { errors: follow.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    unfollow = current_user.followed_users.find_by(followed_id: params[:id])
    unfollow.destroy
    head :no_content
  end

  private

  def follow_params
    params.expect(follow: :followed_id)
  end
end
