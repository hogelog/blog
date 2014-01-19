class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end

  ROOT_PER_PAGE = 5
  def root
    @articles = Article.
      order("id DESC").
      page(params[:page]).
      per(ROOT_PER_PAGE)
  end

  INDEX_PER_PAGE = 10
  def index
    @articles = Article.
      order("id DESC").
      page(params[:page]).
      per(INDEX_PER_PAGE)
  end

  def hiragana
    @article = Article.find(params[:id]).hiragana
    render :show, locals: { hiragana: true }
  end

  private

  def article_params
    Article.extract_title_text(params.require(:article)[:title_text])
  end
end
