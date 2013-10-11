module ArticlesHelper
  def link_to_article(article)
    return unless article
    link_to article.title, article
  end
end
