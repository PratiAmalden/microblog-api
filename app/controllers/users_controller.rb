class UsersController < ApplicationController
  before_action :authenticate_user!

  def feed
    pagy, posts = pagy(current_user.feed, items: 20)

    render json: {
      posts: posts,
      pagination: {
        page: pagy.page,
        pages: pagy.pages,
        count: pagy.count,
        next: pagy.next,
        prev: pagy.prev
      }
    }
  end
end
