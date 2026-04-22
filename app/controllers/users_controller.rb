class UsersController < ApplicationController
  before_action :authenticate_user!

  def feed
    pagy, microposts = pagy(current_user.feed, items: 20)

    render json: {
      microposts: microposts,
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
