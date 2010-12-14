class CommentsController < ApplicationController
  # POST /comments
  # POST /comments.xml
  def create
    @article = Article.find(params[:article_id])
    if user_signed_in?
      params[:comment][:user] = current_user
    end
    @comment = @article.comments.create!(params[:comment])
    redirect_to @article, :notice => "Commented!"
  end
end
