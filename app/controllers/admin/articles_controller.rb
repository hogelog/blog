class Admin::ArticlesController < AdminController
  INDEX_PER_PAGE = 10
  def index
    @articles = Article.
      order("id DESC").
      page(params[:page]).
      per(INDEX_PER_PAGE)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = @login_user
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to admin_path
  end

  def preview
    @article = Article.new(Article.extract_title_text(params[:text]))
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
