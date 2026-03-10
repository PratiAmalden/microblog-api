class LikeController < ApplicationController
  before_action :authenticate_user!, :set_likable

  def create
    reaction = @likable.reactions.find_or_initialize_by(user: current_id)
    reaction.kind = reaction_params[:kind]

    if reaction.save
      render json: reaction, status: :created
    else
      render json: { errors: reaction.errors.full_messages }, status: :unprocessable_content
    end
  end

  def destroy
    reaction = current_user.reactions.find(params[:id])
    reaction.destroy
    head :no_content
  end

  private

  def reaction_params
    params.expect(reaction: [ :kind ])
  end

  def set_likable
    if params[:micropost_id]
      @likable = Micropost.find(params[:micropost_id])
    elsif params[:comments]
      @likable = Comment.find(params[:comment_id])
    end
  end
end
