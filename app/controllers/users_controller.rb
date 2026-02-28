class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    user = User.find(params[:id])
    render json: {
      id: user.id,
      name: user.name,
      email: user.email,
      followings: user.followings.count,
      followers: user.followers.count
    }
  end

  def feed
    @pagy, @microposts = pagy(current_user.feed_scope, items: 20)
    
    render json: {
      microposts: @microposts,
      pagination: {
        page: @pagy.page,
        pages: @pagy.pages,
        count: @pagy.count,
        next: @pagy.next,
        prev: @pagy.prev
      }
    }
  end
end
