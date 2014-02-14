require 'spec_helper'

describe "admin/articles/preview" do
  let(:article) { Article.make(text: text) }
  before do
    assign(:article, article)
    render
  end

  context "with plain code block" do
    let(:text) { "```\nhoge\n```" }

    it "renders preview article" do
      expect(view).to render_template("admin/articles/preview")
    end
  end
end
