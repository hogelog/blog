require 'spec_helper'

describe ArticlesController do
  let(:user) { User.make! }

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

  describe "POST /articles" do
    context "with login user" do
      before { login(user) }

      it "creates new article" do
        post :create, article: {title_text: "title!\r\narticle!"}

        expect(response).to redirect_to(assigns(:article))

        expect(assigns(:article).title).to eq('title!')
        expect(assigns(:article).text).to eq('article!')
      end
    end

    context "with guest user" do
      it "redirects to login" do
        post :create, article: {title_text: "title!\r\narticle!"}
        expect(response).to redirect_to(login_path)
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
