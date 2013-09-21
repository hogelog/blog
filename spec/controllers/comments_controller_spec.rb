require 'spec_helper'

describe CommentsController do
  let(:article) { create(:article) }
  let(:user) { article.user }

  describe "POST /articles/:id/comments" do
    context "with login user" do
      before do
        login(user)
      end

      it "creates new comment" do
        post :create, article_id: article.id, comment: {text: 'comment!'}

        expect(response).to redirect_to(article)
        expect(article.comments).to have(1).record
      end
    end

    context "with guest user" do
      it "redirects to login" do
        post :create, article_id: article.id, comment: {text: 'comment!'}

        expect(response).to redirect_to(login_path)
        expect(article.comments).to have(0).records
      end
    end
  end

end
