require 'spec_helper'

describe Article do
  describe "#comments" do
    let(:article) { create(:article) }
    let(:comments) { 2.times.map{ create(:comment, article: article) } }

    it "returns article's comments" do
      expect(article.comments).to eq(comments)
    end
  end

  describe ".extract_title_text" do
    let(:title_text) { "#{title}\r\n#{text}" }
    subject { Article.extract_title_text(title_text) }

    shared_examples "extracts" do
      it "extracts title and text" do
        expect(subject[:title]).to eq(title)
        expect(subject[:text]).to eq(text)
      end
    end

    context "when empty text" do
      let(:title) { "" }
      let(:text) { "" }
      let(:title_text) { "" }

      include_examples "extracts"
    end

    context "when 1 lines text" do
      let(:title) { "hoge" }
      let(:text) { "" }
      let(:title_text) { "hoge" }

      include_examples "extracts"
    end

    context "when 1 lines text" do
      let(:title) { "hoge" }
      let(:text) { "moge" }

      include_examples "extracts"
    end

    context "when 3 lines text" do
      let(:title) { "hoge" }
      let(:text) { "moge\r\nfuga" }

      include_examples "extracts"
    end
  end
end
