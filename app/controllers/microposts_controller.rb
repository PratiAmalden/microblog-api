class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :destroy ]

  def show
    render json: Micropost.find(params[:id])
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
