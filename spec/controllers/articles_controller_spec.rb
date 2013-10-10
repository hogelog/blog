require 'spec_helper'

describe ArticlesController do
  let(:user) { User.make! }

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

end
