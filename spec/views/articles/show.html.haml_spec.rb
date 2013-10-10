require 'spec_helper'

describe "articles/show.html.haml" do
  include MarkdownHelper

  let(:markdown_text) { "hoge *fuga* moge."}
  let(:html) { markdown(markdown_text).chomp }
  let(:article) { Article.make!(text: markdown_text) }
  before do
    assign(:article, article)
    render
  end

  it "shows markdowned html" do
    expect(rendered).to include(html)
  end
end