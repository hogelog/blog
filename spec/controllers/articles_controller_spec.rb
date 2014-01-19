require 'spec_helper'

describe ArticlesController do
  describe "GET /articles" do
    context "with no articles" do
      it "shows no articles" do
        get :index
        expect(response).to be_success
      end
    end

    context "with an article" do
      let!(:article) { Article.make! }

      it "shows an article" do
        get :index
        expect(response).to be_success
      end
    end
  end

  describe "GET /articles/:id/hiragana" do
    context "when guest user" do
      let(:article) { Article.make! }

      it "shows an hiragana article" do
        get :hiragana, id: article.id
        expect(response).to be_success
      end
    end
  end
end
