require 'spec_helper'

describe Article do
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

    context "when text contains empty lines" do
      let(:title) { "hoge" }
      let(:text) { "\r\n\r\nfuga" }

      include_examples "extracts"
    end
  end

  describe ".prev" do
    context "when 3 articles exists" do
      let!(:articles) { 3.times.map{ Article.make! } }

      context "when first article" do
        subject { Article.all.first.prev }

        it "returns null" do
          expect(subject).to be_nil
        end
      end

      context "when third article" do
        subject { Article.all.third.prev }

        it "returns the second" do
          expect(subject).to eq(articles.second)
        end
      end
    end
  end

  describe ".next" do
    context "with 3 articles" do
      let!(:articles) { 3.times.map{ Article.make! } }

      context "when first article" do
        subject { Article.all.first.next }

        it "returns the second" do
          expect(subject).to eq(articles.second)
        end
      end

      context "when third article" do
        subject { Article.all.third.next }

        it "returns first article" do
          expect(subject).to be_nil
        end
      end
    end
  end

  describe ".hiragana" do
    context "with kanji article" do
      let(:article) { Article.make(title: "漢字のタイトル", text: "漢字の文章") }

      it "returns hiragana entry" do
        expect(article.hiragana.title).to eq("かんじのタイトル")
        expect(article.hiragana.text).to eq("かんじのぶんしょう")
      end
    end
  end
end
