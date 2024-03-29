class CommentsController < ApplicationController
    
  before_action :authenticate_user!
  
  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "コメントできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    Comment.find_by(id: params[:id],post_id: params[:post_id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
