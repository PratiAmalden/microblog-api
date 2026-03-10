class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :destroy, :update ]

  def index
    render json: Micropost.all
  end
  def show
    micropost = Micropost.with_associations.find(params[:id])
    render json: micropost.as_json(
      include: {
        comments:  { only: [ :id, :body, :user_id, :created_at ] },
        reactions: { only: [ :id, :user_id, :kind ] }
      }
    )
  end

  def update
    post = current_user.microposts.find(params[:id])

    if post.update(micropost_params)
      render json: post, status: :ok
    else
      render json: { errors: post.errors.full_messages }
    end
  end

  def create
    micropost = current_user.microposts.build(micropost_params)

    if micropost.save
      render json: micropost, status: :created
    else
      render json: { errors: micropost.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    micropost = current_user.microposts.find(params[:id])

    if micropost.destroy
      head :no_content
    else
      render json: { errors: micropost.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def micropost_params
    params.expect(micropost: [ :title, :body ])
  end
end
