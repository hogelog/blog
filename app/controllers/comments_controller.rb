class CommentsController < ApplicationController
  before_action :require_login

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to @article
  end

  def destroy
    @comment = Comment.find(params[:id])
    @article = @comment.article
    @comment.destroy!
    redirect_to @article
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
