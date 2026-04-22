class ReactionsController < ApplicationController
  before_action :authenticate_user!, :set_likable

  def create
    reaction = Reaction.react(
      user: current_user,
       kind: reaction_params[:kind],
       likable: @likable
    )

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
    elsif params[:comment_id]
      @likable = Comment.find(params[:comment_id])
    end
  end
end
