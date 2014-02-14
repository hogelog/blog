module MarkdownHelper
  class Renderer < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.highlight(code, language || :text)
    end
  end

  def markdown(content)
    markdown = Redcarpet::Markdown.new(
      Renderer,
      autolink: true,
      hard_wrap: true,
      prettify: true,
      no_intraemphasis: true,
      fenced_code_blocks: true,
      lax_spacing: true,
    )
    markdown.render(content).html_safe
  end
end
