require 'spec_helper'

describe User do
  describe "#articles" do
    let(:article) { Article.make! }
    let(:user) { article.user }

    it "returns user's articles" do
      expect(user.articles.first).to eq(article)
    end
  end
end
