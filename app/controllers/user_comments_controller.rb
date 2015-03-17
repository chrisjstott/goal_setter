class UserCommentsController < ApplicationController

  def create
    user_comment = UserComment.new(user_comment_params)
    user_comment.author_id = current_user.id
    user_comment.recipient_id = params[:user_id]
    if user_comment.save
      redirect_to user_url(params[:user_id])
    else
      flash[:errors] = user_comment.errors.full_messages
      redirect_to user_url(params[:user_id])
    end
  end

  def destroy
    UserComment.find(params[:id]).destroy
    redirect_to user_url(params[:user_id])
  end

  private
  def user_comment_params
    params.require(:comment).permit(:content)
  end
end
