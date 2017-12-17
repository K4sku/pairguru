class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.update(comment_params)
      redirect_to movie_path(@comment.movie_id), notice: "Comment saved"
    else
      flash[:alert] = "Action failed"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  def most_active_users
    @most_active_commenters = Rails.cache.fetch("top_week_comments", expires_in: 12.hours) do
       User.top_commenters_last_week.take(10)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :movie_id)
  end
end
