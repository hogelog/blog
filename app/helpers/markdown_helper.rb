module MarkdownHelper
  def markdown(content)
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      autolink: true,
      hard_wrap: true,
      prettify: true,
    )
    markdown.render(content).html_safe
  end
end